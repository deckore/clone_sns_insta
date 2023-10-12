import 'package:flutter/material.dart';

import '../components/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
const ActiveHistory({ Key? key }) : super(key: key);

Widget _activeItemOne() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        AvatarWidget(
          type: AvatarType.TYPE2,
          size: 40,
          thumbPath: "https://cdn.pixabay.com/photo/2023/07/13/20/39/coffee-beans-8125757_1280.jpg",
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text.rich(
            TextSpan(
              text: "Brutalist",
              style: TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "님이 회원님의 게시물을 좋아합니다.",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                TextSpan(
                  text: " 5일 전",
                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black54,),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _newRecentlyActiveView(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 15),
        _activeItemOne(),
        _activeItemOne(),
        _activeItemOne(),
        _activeItemOne(),
        _activeItemOne(),
      ],
    ),
  );
}
Widget _newRecentlyWeekView() {
  return Container();
}
Widget _newRecentlyMonthView() {
  return Container();
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("활동", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyActiveView("오늘"),
            _newRecentlyActiveView("이번주"),
            _newRecentlyActiveView("이번달"),
          ],
        ),
      ),
    );
  }
}