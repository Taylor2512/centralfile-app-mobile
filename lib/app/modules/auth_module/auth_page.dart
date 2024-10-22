import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test01/app/modules/auth_module/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Obx(
          () => controller.isLoggedIn.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You are logged in!'),
                    ElevatedButton(
                      onPressed: controller.logout,
                      child: const Text('Logout'),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Please log in'),
                      TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(labelText: 'Username'),
                      ),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.login(
                          usernameController.text,
                          passwordController.text,
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}