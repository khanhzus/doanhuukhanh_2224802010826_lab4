import 'package:flutter/material.dart';
import '../controllers/auth_services.dart';
import 'home.dart';
import 'sign_up_page.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthServices();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // 📧 EMAIL
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 15),

            // 🔒 PASSWORD
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 25),

            // 🔐 LOGIN BUTTON
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.login(email.text, password.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login failed")),
                  );
                }
              },
              child: const Text("Login"),
            ),

            const SizedBox(height: 10),

            // 🔥 GOOGLE LOGIN
            OutlinedButton.icon(
              onPressed: () async {
                var user = await auth.signInWithGoogle();

                if (user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Google login failed")),
                  );
                }
              },
              icon: const Icon(Icons.g_mobiledata),
              label: const Text("Continue with Google"),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📝 SIGN UP
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignUpPage()),
                );
              },
              child: const Text("Don't have account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}