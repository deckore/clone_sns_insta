import 'package:clone_sns_insta/src/controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../controller/mypage_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }

  static additionalBinding() {
    Get.put(MyPageController(), permanent: true);
  }
}