// import 'package:authfirebase/authservice.dart';
// import 'package:authfirebase/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
//
//
// class Signup extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Sign Up")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await AuthService().signup(_emailController.text, _passwordController.text, context);
//               },
//               child: const Text("Sign Up"),
//             ),
//             RichText(
//               text: TextSpan(
//                 text: "Already have an account? ",
//                 children: [
//                   TextSpan(
//                     text: "Log In",
//                     style: TextStyle(color: Colors.blue),
//                     recognizer: TapGestureRecognizer()..onTap = () {
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Login()));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:authfirebase/authservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Signup extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
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
                await AuthService().signup(
                  _emailController.text,
                  _passwordController.text,
                  context,
                );
              },
              child: const Text("Sign Up"),
            ),
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                children: [
                  TextSpan(
                    text: "Log In",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      Navigator.pushReplacementNamed(context, '/login');
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
