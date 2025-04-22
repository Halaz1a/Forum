import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'authProvider.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();
  static const _keyEmail = 'email';
  static const _keyPassword = 'password';
  static const _keyToken = 'token';
  static const _keyRoles = 'roles';

  Future<void> saveCredentials(String email, String password) async {
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyPassword, value: password);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<void> saveRoles(List<dynamic> roles) async {
    final rolesJson = jsonEncode(roles);
    await _storage.write(key: _keyRoles, value: rolesJson);
  }

  Future<Map<String, String?>> readCredentials() async {
    String? email = await _storage.read(key: _keyEmail);
    String? password = await _storage.read(key: _keyPassword);
    return {'email': email, 'password': password};
  }

  Future<String?> readToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<List<dynamic>> readRoles() async {
    final rolesJson = await _storage.read(key: _keyRoles);
    return List<dynamic>.from(jsonDecode(rolesJson!));
  }

  Future<bool> readAdmin() async {
    final rolesJson = await _storage.read(key: _keyRoles);
    List<dynamic> roles = List<dynamic>.from(jsonDecode(rolesJson!));
    return roles.contains("ROLE_ADMIN");
  }

  Future<void> deleteCredentials() async {
    await _storage.delete(key: _keyEmail);
    await _storage.delete(key: _keyPassword);
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRoles);
  }

  Future<void> logout() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyRoles);
  }
}
