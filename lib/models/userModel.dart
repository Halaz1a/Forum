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
  final DateTime dateInscription;

  User({
    required this.id,
    required this.email,
    required this.roles,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.dateInscription
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      password: json['password'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      dateInscription: json['dateInscription'] != null
          ? DateTime.parse(json['dateInscription']).toLocal()
          : DateTime.now(),
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
      'dateInscription' : dateInscription.toIso8601String(),
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

  Future<User?> getUserByEmail(String email) async {
    final response = await http.get(
      Uri.parse('${Config.apiUrl}/users/email/$email'),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      print("Erreur lors de la récupération de l'utilisateur : ${response.statusCode} - ${response.body}");
      return null;
    }
  }

}