import 'dart:convert';
import 'package:forum/tools/secureStorage.dart';
import 'package:http/http.dart' as http;
import '../tools/config.dart';

class Forum{
  final int id;
  final String nom;

  Forum({
    required this.id,
    required this.nom,
  });

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'],
      nom: json['nom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'nom' : nom
    };
  }
}

class ForumApi{

  final storage = SecureStorage();

  Future<List<Forum>> allForums() async {
    final response = await http.get(Uri.parse('${Config.apiUrl}/forums'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Forum> forums = data.map((json) {
        return Forum.fromJson(json);
      }).toList();

      print(response.body);
      return forums;

    } else {
      throw Exception('Failed to load forums');
    }
  }

  Future<bool> addForum({required String nom}) async {
    final token = await storage.readToken();

    final response = await http.post(Uri.parse('${Config.apiUrl}/forums'),
      headers: {'Authorization' : 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({
        'nom' : nom.toUpperCase()
      })
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add forum');
    }
  }

  Future<bool> editForum({required int id, required String nom}) async {
    final token = await storage.readToken();

    final response = await http.patch(Uri.parse('${Config.apiUrl}/forums/$id'),
        headers: {'Authorization' : 'Bearer $token', 'Content-Type': 'application/merge-patch+json'},
        body: jsonEncode({
          'nom' : nom.toUpperCase()
        })
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to edit forum');
    }
  }

  Future<bool> deleteForum({required int id}) async {
    final token = await storage.readToken();

    final response = await http.delete(Uri.parse('${Config.apiUrl}/forums/$id'),
        headers: {'Authorization' : 'Bearer $token', 'Content-Type': 'application/json'}
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete forum');
    }
  }
}