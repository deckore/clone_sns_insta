import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/image_data.dart';
import '../controller/upload_controller.dart';


class UploadDescription extends GetView<UploadController> {
  const UploadDescription({ Key? key }) : super(key: key);

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          SizedBox(
            width: 60, height: 60,
            child: Image.file(
              controller.filteredImage!,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: TextField(
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 14),
                hintText: "Input Content",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoOnt(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      child: Text(title, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget get line => const Divider(color: Colors.grey);

  Widget snsInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Facebook",
                style: TextStyle(fontSize: 16),
              ),
              Switch(value: false, onChanged: (bool value) {},),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Twitter",
                style: TextStyle(fontSize: 16),
              ),
              Switch(value: false, onChanged: (bool value) {},),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tumblr",
                style: TextStyle(fontSize: 16),
              ),
              Switch(value: false, onChanged: (bool value) {},),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: ImageData(
              IconsPath.backBtnIcon,
              width: 50,
            ),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              
            },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: ImageData(
                IconsPath.uploadComplete,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0, top: 0, right: 0, bottom: 0,
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _description(),
                    line,
                    infoOnt("사람 태그하기"),
                    line,
                    infoOnt("위치 추가"),
                    line,
                    infoOnt("다른 미디어에 게시"),
                    snsInfo(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}