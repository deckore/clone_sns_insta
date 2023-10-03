import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/image_data.dart';
import '../../controller/bottom_nav_controller.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({ Key? key }) : super(key: key);

  @override
  _SearchFocusState createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(menu, style: const TextStyle(fontSize: 12, color: Colors.black)),
    );
  }

  PreferredSizeWidget _tabMenu() {
    return PreferredSize(
          child: Container(
            height: AppBar().preferredSize.height,
            width: Size.infinite.width,
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
            //color: Colors.indigo,
            child: TabBar(
              controller: tabController,
              tabs: [
                _tabMenuOne("Popular"),
                _tabMenuOne("Account"),
                _tabMenuOne("Audio"),
                _tabMenuOne("Tag"),
                _tabMenuOne("Place"),
              ],
              indicatorColor: Colors.black,
            ),
          ),
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        );
  }

  Widget _body() {
    return TabBarView(
      controller: tabController,
      children: const [
        Center(child: Text("1")),
        Center(child: Text("2")),
        Center(child: Text("3")),
        Center(child: Text("4")),
        Center(child: Text("5")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          //GetX
          // onTap: Get.back,
          //Navigator
          // onTap:() {Get.find<BottomNavController>().willPopAction();},
          //static get to Syntax
          onTap: BottomNavController.to.willPopAction,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ImageData(IconsPath.backBtnIcon),
          )
        ),
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffefefef),
          ),
          child: const TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Keywords",
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true,
            ),
          ),
        ),
        bottom: _tabMenu(),
      ),
      body: _body(),
    );
  }
}