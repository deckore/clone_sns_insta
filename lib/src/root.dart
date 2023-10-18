import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'controller/auth_controller.dart';
import 'models/insta_user.dart';
import 'pages/login.dart';
import 'pages/signup_page.dart';

class Root extends GetView<AuthController> {
const Root({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          controller.loginUser(user.data!.uid);
          return FutureBuilder<IUser>(builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const App();
            } else {
              return Obx(() => controller.user.value.uid != null
                ? const App()
                : SignupPage(uid: user.data!.uid));
            }
          });
        } else {
          return Login();
        }
      },
    );
  }
}