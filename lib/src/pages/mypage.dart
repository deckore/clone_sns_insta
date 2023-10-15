import 'package:clone_sns_insta/src/components/avatar_widget.dart';
import 'package:flutter/material.dart';

import '../components/image_data.dart';
import '../components/user_card.dart';

class MyPage extends StatefulWidget {
const MyPage({ Key? key }) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }


  Widget _statisticsOne(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
      ],
    );
  }

  Widget _information() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarWidget(
                type: AvatarType.TYPE3,
                thumbPath: "https://cdn.pixabay.com/photo/2023/07/13/20/39/coffee-beans-8125757_1280.jpg",
                size: 80,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _statisticsOne("Post", 15)),
                    Expanded(child: _statisticsOne("Followers", 15)),
                    Expanded(child: _statisticsOne("Following", 3)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: const Text("안녕하세요. 월급 독립을 꿈꾸는 맨딩입니다.", style: TextStyle(fontSize: 12, color: Colors.black,),),
        ),
      ],
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: Color(0xffdedede))),
              child: const Text('Edit profile', style: TextStyle(fontSize: 14, color: Colors.black), textAlign: TextAlign.center,),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), border: Border.all(color: Color(0xffdedede)), color: Color(0xffefefef)),
            child: ImageData(IconsPath.addFriend),
          ),
        ],
      ),
    );
  }

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Discover People', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
              Text('See All', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.blue)),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
              List.generate(10, (index) => UserCard(userId: "맨딩$index", description: "누구누구$index님이 팔로우합니다.")).toList(),
          ),
        ),
      ],
    );
  }

  Widget _tabMenu() {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      tabs: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10,),
          child: ImageData(IconsPath.gridViewOn),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10,),
          child: ImageData(IconsPath.myTagImageOff),
        ),
      ],
    );
  }

  Widget _tabView() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Main Scroll이 동작하도록 묵살
      shrinkWrap: true,
      itemCount: 100,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brutalist", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              
            },
            child: ImageData(
              IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              
            },
            child: ImageData(
              IconsPath.menuIcon,
              width: 50,
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _information(),
            _menu(),
            _discoverPeople(),
            const SizedBox(height: 20),
            _tabMenu(),
            _tabView(),
          ],
        ),
      ),
    );
  }
}