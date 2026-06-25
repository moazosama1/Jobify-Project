import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/utils/shared_prefs_manager.dart';
import 'package:jobify_project/data/data_source/ai_chat_local_data_source.dart';
import 'package:jobify_project/api/models/ai_chat_message_model.dart';

@Injectable(as: AiChatLocalDataSource)
class AiChatLocalDataSourceImpl implements AiChatLocalDataSource {
  final SharedPrefsManager _sharedPrefsManager;

  AiChatLocalDataSourceImpl(this._sharedPrefsManager);

  @override
  Future<List<AiChatMessageModel>> getChatHistory() async {
    final jsonStr = _sharedPrefsManager.getString(key: ConstKeys.kAiChatHistory);
    if (jsonStr == null || jsonStr.isEmpty) {
      return const [];
    }
    try {
      final List<dynamic> jsonList = jsonDecode(jsonStr) as List<dynamic>;
      return jsonList
          .map((item) => AiChatMessageModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return const [];
    }
  }

  @override
  Future<void> saveChatHistory(List<AiChatMessageModel> history) async {
    final jsonList = history.map((item) => item.toJson()).toList();
    final jsonStr = jsonEncode(jsonList);
    await _sharedPrefsManager.setString(key: ConstKeys.kAiChatHistory, value: jsonStr);
  }

  @override
  Future<void> clearChatHistory() async {
    await _sharedPrefsManager.remove(key: ConstKeys.kAiChatHistory);
  }
}
