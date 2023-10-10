import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:get/get.dart';

import '../components/image_data.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<AssetPathEntity> albums = <AssetPathEntity>[];

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    }
  }

  void _loadData() async {
    print(albums.first.name);
  }

  Widget _imagePreview() {
    /* GetX 의존성 제거 */
    var width = MediaQuery.of(context).size.width;
    return Container(
      // width: Get.width,
      // height: Get.width,
      width: width,
      height: width,
      color: Colors.grey,
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text(
                  "갤러리",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_drop_down),
              ],
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
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.red,
          );
        });
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
            onTap: () {},
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
