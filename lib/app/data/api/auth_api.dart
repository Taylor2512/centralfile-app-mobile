import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class AuthApi {
  static final String _baseUrl = (dotenv.env['API_URL'] ?? '') + '/api/Account';

  HttpClient _createHttpClient() {
    final client = HttpClient();
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  }

  Future<String?> login(String username, String password) async {
    final client = _createHttpClient();

    final request = await client.postUrl(Uri.parse('$_baseUrl/login'));
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.add(utf8.encode(jsonEncode(<String, String>{
      'username': username,
      'password': password,
    })));

    final response = await request.close();
    if (response.statusCode == 200) {
      final responseData = await response.transform(utf8.decoder).join();
      final jsonResponse = json.decode(responseData);
      return jsonResponse['token'];
    } else {
      throw Exception('Failed to login: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> register(String username, String password) async {
    final client = _createHttpClient();

    final request = await client.postUrl(Uri.parse('$_baseUrl/register'));
    request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    request.add(utf8.encode(jsonEncode(<String, String>{
      'username': username,
      'password': password,
    })));

    final response = await request.close();
    if (response.statusCode != 201) {
      throw Exception('Failed to register: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}