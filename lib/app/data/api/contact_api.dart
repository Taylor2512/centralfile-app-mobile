import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactApi {
 static final String _baseUrl = (dotenv.env['API_URL'] ?? '') + '/api/Contact';
  Future<List<Map<String, dynamic>>> getContacts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> addContact(Map<String, dynamic> contact) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(contact),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add contact');
    }
  }

  Future<void> updateContact(String id, Map<String, dynamic> contact) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(contact),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update contact');
    }
  }

  Future<void> deleteContact(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete contact');
    }
  }
}
