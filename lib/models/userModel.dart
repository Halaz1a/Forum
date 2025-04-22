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

class UserApi{

  Future<int> registerUser({required String email, required String password, required String nom,
      required String prenom}) async {

    final response = await http.post(Uri.parse('${Config.apiUrl}/users'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'roles': ["ROLE_USER"],
        'password': password,
        'nom': nom,
        'prenom': prenom,
        'dateInscription': DateTime.now().toString(),
      }),
    );

    if (response.statusCode == 201) {
      return response.statusCode;

    } else {
      print("Échec de la requête : Code de statut ${response.statusCode}, Réponse : ${response.body}");
          return response.statusCode;
    }
  }

  Future<http.Response> login(String email, String password) async {

    final response = await http.post(Uri.parse('${Config.apiUrl}/authentication_token'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
}