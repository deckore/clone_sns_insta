import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'controller/auth_controller.dart';
import 'pages/login.dart';

class Root extends GetView<AuthController> {
const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          controller.loginUser(user.data!.uid);
          return FutureBuilder(builder: (context, snapshot) {
            return const App();
          });
        } else {
          return Login();
        }
      },
    );
  }
}