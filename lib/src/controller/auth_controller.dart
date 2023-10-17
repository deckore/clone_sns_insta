import 'package:clone_sns_insta/src/repository/user_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<bool?> loginUser(String uid) async {
    // DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    print(userData);
    return userData;
  }
}