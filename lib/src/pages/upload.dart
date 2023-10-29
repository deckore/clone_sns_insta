import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:get/get.dart';

import '../components/image_data.dart';
import '../controller/upload_controller.dart';

class Upload extends GetView<UploadController> {
  Upload({Key? key}) : super(key: key);


  // @override
  // void initState() {
  //   super.initState();
  //   _loadPhotos();
  // }

  // void update() => setState(() {});

  Widget _imagePreview() {
    /* GetX 의존성 제거 */
    // var width = MediaQuery.of(context).size.width;
    var width = Get.width;
    return Obx(() => Container(
      // width: Get.width,
      // height: Get.width,
      width: width,
      height: width,
      color: Colors.grey,
      child: _photoWidget(controller.selectedImage.value, width.toInt(), builder: (data) {
              return Image.memory(data, fit: BoxFit.cover);
            }),
    ));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: Get.context!,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                isScrollControlled: true,
                constraints: BoxConstraints(
                    // SafeArea를 제외한 나머지 영역까지
                    maxHeight: MediaQuery.of(Get.context!).size.height -
                        MediaQuery.of(Get.context!).padding.top),
                builder: (_) => Container(
                  height: controller.albums.length > 10
                      ? Size.infinite.height
                      : controller.albums.length * 60,
                  // color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          width: 40,
                          height: 4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              controller.albums.length,
                              (index) => GestureDetector(
                                onTap:() {
                                  controller.changeAlbum(controller.albums[index]);
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(controller.albums[index].name),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Obx(() => Text(
                    controller.headerTitle.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff808080),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      ImageData(IconsPath.imageSelectIcon),
                      const SizedBox(width: 7),
                      const Text(
                        "여러 항목 선택",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  )),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: ImageData(IconsPath.cameraIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return Obx(() => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: controller.imageList.length,
        itemBuilder: (BuildContext context, int index) {
          return _photoWidget(controller.imageList[index], 200, builder: (data) {
            return GestureDetector(
              onTap: () {
                controller.changeSelectedImage(controller.imageList[index]);
                // update();
              },
              child: Obx(() => Opacity(
                opacity: controller.imageList[index] == controller.selectedImage.value
                         ? 0.3
                         : 1,
                child: Image.memory(
                  data,
                  fit: BoxFit.cover,
                ),
              ),
              ),
            );
          });
        })
    );
  }

  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
      future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return builder(snapshot.data!);
          /* Builder를 받아서 처리로 변경
          return Opacity(
            opacity: asset == selectedImage ? 0.3 : 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
          */
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            // Get.back();
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(IconsPath.closeImage),
          ),
        ),
        title: const Text(
          "New Post",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: controller.gotoImageFilter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(IconsPath.nextImage, width: 50),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            // _imageSelectList(),
            /**
             * SingleChildScrollView 아래 GridView.builder를 직접 사용하는 경우
             * 빌드가 되지 않는 현상이 발생하여 SizedBox로 감싼 후
             * 일단 Get.height로 지정해 둠
             */
            SizedBox(
              // width: Get.width,
              // height: Get.height,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _imageSelectList(),
            ),
          ],
        ),
      ),
    );
  }
}
