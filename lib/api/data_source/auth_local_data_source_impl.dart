import 'package:injectable/injectable.dart';
import 'package:jobify_project/core/constants/const_keys.dart';
import 'package:jobify_project/core/utils/secure_storage_manager.dart';
import 'package:jobify_project/data/data_source/auth_local_data_source.dart';

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageManager _secureStorageManager;

  AuthLocalDataSourceImpl(this._secureStorageManager);

  @override
  Future<void> saveToken(String token) async {
    await _secureStorageManager.setString(key: ConstKeys.kUserToken, value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _secureStorageManager.getString(key: ConstKeys.kUserToken);
  }

  @override
  Future<void> saveRole(String role) async {
    await _secureStorageManager.setString(key: ConstKeys.kUserStatus, value: role);
  }

  @override
  Future<String?> getRole() async {
    return await _secureStorageManager.getString(key: ConstKeys.kUserStatus);
  }

  @override
  Future<void> clear() async {
    await _secureStorageManager.remove(key: ConstKeys.kUserToken);
    await _secureStorageManager.remove(key: ConstKeys.kUserStatus);
  }
}
