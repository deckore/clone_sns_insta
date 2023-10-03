import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiver/iterables.dart';

class Search extends StatefulWidget {
const Search({ Key? key }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<List<int>> groupBox = [[], [], []];
  List<int> groupIndex = [0, 0, 0];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      
      var gi = groupIndex.indexOf(min<int>(groupIndex)!); //i % 3;
      var size = 1;
      if (gi != 1) {
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gi].add(size);
      groupIndex[gi] += size;
    }
    print(groupBox);
  }

  Widget _appbar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            margin: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffefefef),
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                Text("검색", style: TextStyle(fontSize: 15, color: Color(0xff838383)),)
              ]
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: const Icon(Icons.location_pin),
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          groupBox.length,
          (index) => Expanded(
            child: Column(
              children: List.generate(
                groupBox[index].length,
                (jndex) => Container(
                  height: Get.width * 0.33 * groupBox[index][jndex],
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.primaries[
                      Random().nextInt(Colors.primaries.length)
                    ],
                  ),
                  child: CachedNetworkImage(
                    imageUrl: "https://cdn.pixabay.com/photo/2023/08/30/17/59/snowflakes-8223860_1280.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        /*
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 140,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 140,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 140,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
        */
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _appbar(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}