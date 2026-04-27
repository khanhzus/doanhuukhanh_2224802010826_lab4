import 'package:flutter/material.dart';
import '../controllers/auth_services.dart';

class SignUpPage extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthServices();

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: password, decoration: const InputDecoration(labelText: "Password"), obscureText: true),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await auth.register(email.text, password.text);
                Navigator.pop(context);
              },
              child: const Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}