import 'package:flutter/material.dart';
import './components/image_data.dart';
import './controller/bottom_nav_controller.dart';
import 'package:get/get.dart';

import 'components/avatar_widget.dart';
import 'pages/active_history.dart';
import 'pages/home.dart';
import 'pages/mypage.dart';
import 'pages/search.dart';

class App extends GetView<BottomNavController> { //StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(() => Scaffold(
        backgroundColor: Colors.indigoAccent,
        //appBar: AppBar(),
        body: IndexedStack(
          index: controller.pageIndex.value,
          children: [
            const Home(),
            Navigator(
              key: controller.searchPageNavigationKey,
              onGenerateRoute: (routeSetting) {
                return MaterialPageRoute(
                  builder:(context) => const Search(),
                );
              },
            ),
            Container(), // Upload Dummy
            const ActiveHistory(),
            const MyPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          currentIndex: controller.pageIndex.value,
          onTap: controller.changeBottomNav,
          items: [
            //BottomNavigationBarItem(icon: Image.asset('assets/images/add_friend_icon.jpg')),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.homeOff),
              activeIcon: ImageData(IconsPath.homeOn),
              label: "HOME"
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.searchOff),
              activeIcon: ImageData(IconsPath.searchOn),
              label: "search"
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.uploadIcon),
              label: ""
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.activeOff),
              activeIcon: ImageData(IconsPath.activeOn),
              label: ""
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: //Obx(() => /* Trying..... */
                       AvatarWidget(
                        type: AvatarType.TYPE2,
                        // thumbPath: controller.targetUser.value.thumbnail!,
                        thumbPath: "https://cdn.pixabay.com/photo/2023/07/13/20/39/coffee-beans-8125757_1280.jpg",
                        size: 30,
                      ),
                      //),
              ),
              label: ""
            ),
          ],
        ),
      ),
      ),
      //onWillPop: () async {return false;} 
      onWillPop: controller.willPopAction,
    );
  }
}
