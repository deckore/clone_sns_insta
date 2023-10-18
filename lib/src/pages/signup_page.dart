import 'package:clone_sns_insta/src/controller/auth_controller.dart';
import 'package:flutter/material.dart';

import '../models/insta_user.dart';

class SignupPage extends StatefulWidget {
  final String uid;
  const SignupPage({ Key? key, required this.uid }) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController nicknameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset("assets/images/default_image.png", fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () {},
          child: const Text("이미지변경"),
        ),
      ],
    );
  }

  Widget _nickname() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: nicknameController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "NickName",
        ),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: descriptionController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          hintText: "Description",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("SignUp", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _avatar(),
            const SizedBox(height: 30),
            _nickname(),
            const SizedBox(height: 30),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: ElevatedButton(
          onPressed: () {
            // validation 일단 생략
            var signupUser = IUser(
              uid: widget.uid,
              nickname: nicknameController.text,
              description: descriptionController.text,
            );
            AuthController.to.signup(signupUser);
          },
          child: const Text("회원가입"),
        ),
      ),
    );
  }
}