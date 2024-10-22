import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test01/app/routes/app_pages.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var token = ''.obs;

  // Métodos relacionados con autenticación
  Future<void> login(String username, String password) async {
    // final url = Uri.parse('https://example.com/api/auth/login');
    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: json.encode({'username': username, 'password': password}),
    // );
    //
    // if (response.statusCode == 200) {
    //   final responseData = json.decode(response.body);
    //   token.value = responseData['token'];
    //   isLoggedIn.value = true;
    //   Get.toNamed(Routes.CONTACT);
    // } else {
    //   // Manejar error de autenticación
    //   isLoggedIn.value = false;
    // }
    if(username == 'admin' && password == 'admin') {
      token.value = 'token';
      isLoggedIn.value = true;
      Get.toNamed(Routes.CONTACT);
    }
  }

  void logout() {
    // Lógica de cierre de sesión
    token.value = '';
    isLoggedIn.value = false;
  }
}