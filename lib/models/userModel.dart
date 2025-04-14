import 'dart:convert';
import 'package:http/http.dart' as http;
import '../tools/config.dart';

class User{
  final int id;
  final String email;
  final List<String> roles;
  final String password;
  final String nom;
  final String prenom;
  final DateTime dateInscritpion;

  User({
    required this.id,
    required this.email,
    required this.roles,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.dateInscritpion
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      roles: json['roles'],
      password: json['password'],
      nom: json['nom'],
      prenom: json['prenom'],
      dateInscritpion: DateTime.parse(json['dateInscritpion']).toLocal(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'email' : email,
      'roles' : roles,
      'password' : password,
      'nom' : nom,
      'prenom' : prenom,
      'dateInscritpion' : dateInscritpion.toIso8601String(),
    };
  }
}