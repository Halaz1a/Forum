import 'dart:convert';
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

  Future<List<Forum>> allForums() async {
    final response = await http.get(Uri.parse('${Config.apiUrl}/forums'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      final List<dynamic> data = body['member'];

      List<Forum> forums = data.map((json) {
        return Forum.fromJson(json);
      }).toList();

      return forums;

    } else {
      throw Exception('Failed to load forums');
    }
  }
}