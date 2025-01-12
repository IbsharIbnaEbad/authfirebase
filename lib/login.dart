import 'package:authfirebase/authservice.dart';
import 'package:authfirebase/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Log In")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signin(_emailController.text, _passwordController.text, context);
              },
              child: const Text("Log In"),
            ),
            RichText(
              text: TextSpan(
                text: "New user? ",
                children: [
                  TextSpan(
                    text: "Create Account",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Signup()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
