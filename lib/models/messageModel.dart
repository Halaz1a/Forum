import 'dart:convert';
import 'package:forum/tools/secureStorage.dart';
import 'package:http/http.dart' as http;
import '../tools/config.dart';

class Message{
  final int id;
  final String titre;
  final DateTime datePoste;
  final String contenu;
  final int userId;
  final String userPrenom;
  final String userNom;
  final int forumId;
  final int? parentId;
  final List<int>? reponsesId;


  Message({
    required this.id,
    required this.titre,
    required this.datePoste,
    required this.contenu,
    required this.userId,
    required this.userPrenom,
    required this.userNom,
    required this.forumId,
    this.parentId,
    this.reponsesId
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      titre: json['titre'],
      datePoste: DateTime.parse(json['datePoste']).toLocal(),
      contenu: json['contenu'],
      userId: json['user']['id'],
      userNom: json['user']['nom'],
      userPrenom: json['user']['prenom'],
      forumId: json['forum']['id'],
      parentId: json['parent'] != null 
        ? json['parent']['id']
        : null
    );
  }

  Map<String, dynamic> toJson() {
    String? parentLink;
    if(parentId != null) {
      parentLink = "/forum/api/messages/$parentId";
    }
    return {
      'id' : id,
      'titre' : titre,
      'datePoste' : datePoste,
      'contenu' : contenu, 
      'user' : "/forum/api/users/$userId",
      'forum' : "/forum/api/forum/$forumId",
      'parent' : parentLink
    };
  }
}

class MessageApi{

  final storage = SecureStorage();

  Future<List<Message>> allMessages() async {
    final response = await http.get(Uri.parse('${Config.apiUrl}/messages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Message> forums = data.map((json) {
        return Message.fromJson(json);
      }).toList();

      return forums;

    } else {
      throw Exception('Failed to load forums');
    }
  }

  Future<List<Message>> messagesSources(int forumId) async {
    final response = await http.get(Uri.parse('${Config.apiUrl}/messages/forum/$forumId/roots'));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      final List<dynamic> members = data['hydra:member'];

      List<Message> messages = members.map((json) => Message.fromJson(json)).toList();

      return messages;

    } else {
      throw Exception('Failed to load messages sources');
    }
  }

    Future<List<Message>> messageReponses(int messageId) async {
    final response = await http.get(Uri.parse('${Config.apiUrl}/messages/id/$messageId/responses'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Message> messages = data.map((json) {
        return Message.fromJson(json);
      }).toList();

      return messages;

    } else {
      throw Exception('Failed to load message responses');
    }
  }

  Future<bool> addMessage({required String titre, required String contenu, required int userId, required int forumId, int? parentId}) async {
    String? parentLink;
    if (parentId != null) {
      parentLink = "/forum/api/messages/$parentId";
    }
    
    final token = await storage.readToken();

    final response = await http.post(Uri.parse('${Config.apiUrl}/messages'),
      headers: {'Authorization' : 'Bearer $token', 'Content-Type': 'application/json'},
      body: jsonEncode({
      'titre' : titre,
      'datePoste' : DateTime.now(),
      'contenu' : contenu, 
      'user' : "/forum/api/users/$userId",
      'forum' : "/forum/api/forum/$forumId",
      'parent' : parentLink
      })
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add message');
    }
  }

  Future<bool> deleteMessage({required int id}) async {
    final token = await storage.readToken();

    final response = await http.delete(Uri.parse('${Config.apiUrl}/messages/$id'),
        headers: {'Authorization' : 'Bearer $token', 'Content-Type': 'application/json'}
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete message');
    }
  }
}