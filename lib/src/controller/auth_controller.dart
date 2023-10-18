import 'package:clone_sns_insta/src/repository/user_repository.dart';
import 'package:get/get.dart';

import '../models/insta_user.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rx<IUser> user = IUser().obs;

  Future<IUser?> loginUser(String uid) async {
    // DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    return userData;
  }

  void signup(IUser signupUser) async {
    var result = await UserRepository.signup(signupUser);
    if (result) user(signupUser);
  }
}