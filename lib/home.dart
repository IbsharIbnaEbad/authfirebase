import 'package:authfirebase/authservice.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Center(
          child:
          ElevatedButton(onPressed : () async{
            await AuthService().signout(context);
          }, child : const Text("Sign Out")),
        )
    );
  }
}
