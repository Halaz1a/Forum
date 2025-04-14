import 'package:crypto/crypto.dart';
import 'dart:convert';

class Verifications {

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var passwordHash = sha256.convert(bytes);
    return passwordHash.toString();
  }
}