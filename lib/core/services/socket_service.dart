import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/constants/end_points.dart';
import 'package:jobify_project/core/utils/secure_storage_manager.dart';

@lazySingleton
class SocketService {
  final SecureStorageManager _secureStorageManager;
  io.Socket? _socket;

  // Stream controllers to broadcast socket events to the app
  final _newMessageController = StreamController<Map<String, dynamic>>.broadcast();
  final _messageSeenController = StreamController<Map<String, dynamic>>.broadcast();
  final _typingController = StreamController<Map<String, dynamic>>.broadcast();
  final _stopTypingController = StreamController<Map<String, dynamic>>.broadcast();
  final _userOnlineController = StreamController<String>.broadcast();
  final _userOfflineController = StreamController<String>.broadcast();

  // Expose streams
  Stream<Map<String, dynamic>> get onNewMessage => _newMessageController.stream;
  Stream<Map<String, dynamic>> get onMessageSeen => _messageSeenController.stream;
  Stream<Map<String, dynamic>> get onTyping => _typingController.stream;
  Stream<Map<String, dynamic>> get onStopTyping => _stopTypingController.stream;
  Stream<String> get onUserOnline => _userOnlineController.stream;
  Stream<String> get onUserOffline => _userOfflineController.stream;

  String? _connectedToken;

  SocketService(this._secureStorageManager);

  Future<void> connect() async {
    final token = await _secureStorageManager.getString(key: ConstKeys.kUserToken);
    if (token == null) return;

    if (_socket != null && _socket!.connected) {
      if (_connectedToken == token) {
        return;
      }
      print('🔌 Reconnecting socket because token changed');
      _socket!.disconnect();
      _socket = null;
    }
    
    _connectedToken = token;

    // Use baseUrl but remove trailing slash if exists for socket
    String serverUrl = EndPoints.baseUrl;
    if (serverUrl.endsWith('/')) {
      serverUrl = serverUrl.substring(0, serverUrl.length - 1);
    }

    print('🔌 Connecting to Socket URL: $serverUrl');
    print('🔑 Socket Token: $token');

    final String rawToken = token.replaceFirst('Bearer ', '');
    final String bearerToken = token.startsWith('Bearer ') ? token : 'Bearer $token';

    _socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {
        'token': rawToken,
        'Authorization': bearerToken,
      },
      'query': {
        'token': rawToken,
      },
      'extraHeaders': {
        'Authorization': bearerToken,
      }
    });

    _socket!.connect();

    _socket!.onConnect((_) {
      print('Socket Connected Successfully');
    });

    _socket!.onConnectError((data) {
      print('Socket Connect Error: $data');
    });

    _socket!.onError((data) {
      print('Socket Error: $data');
    });

    _socket!.on('new-message', (data) {
      print('📩 Socket Service received new-message: $data');
      if (data is Map<String, dynamic>) {
        _newMessageController.add(data);
      }
    });

    _socket!.on('message-seen', (data) {
      if (data is Map<String, dynamic>) {
        _messageSeenController.add(data);
      }
    });

    _socket!.on('typing', (data) {
      if (data is Map<String, dynamic>) {
        _typingController.add(data);
      }
    });

    _socket!.on('stop-typing', (data) {
      if (data is Map<String, dynamic>) {
         _stopTypingController.add(data);
      }
    });

    _socket!.on('user-online', (userId) {
      if (userId is String) _userOnlineController.add(userId);
    });

    _socket!.on('user-offline', (userId) {
      if (userId is String) _userOfflineController.add(userId);
    });

    _socket!.onDisconnect((_) {
      print('Socket Disconnected');
    });
  }

  void sendTyping(String receiverId) {
    _socket?.emit('typing', {'receiverId': receiverId});
  }

  void sendStopTyping(String receiverId) {
    _socket?.emit('stop-typing', {'receiverId': receiverId});
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
    _connectedToken = null;
  }
}
