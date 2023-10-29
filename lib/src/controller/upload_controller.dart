import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image/image.dart' as imageLib;
import 'package:photo_manager/photo_manager.dart';
import 'package:photofilters/photofilters.dart';

import '../pages/upload_description.dart';

class UploadController extends GetxController {
  var albums = <AssetPathEntity>[];
  RxString headerTitle = ''.obs;
  RxList<AssetEntity> imageList = <AssetEntity>[].obs;
  Rx<AssetEntity> selectedImage = AssetEntity(
    id: "0",
    typeInt: 0,
    width: 0,
    height: 0,
  ).obs;
  File? filteredImage;

  @override
  void onInit() {
    super.onInit();
    print("onInit -> UploadController");
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
      // Test Code
      /*
      albums.addAll([
        AssetPathEntity()..name = '1',
        AssetPathEntity()..name = '1',
        AssetPathEntity()..name = '1',
      ]);
      */
      _loadData();
    }
  }

  void _loadData() async {
    changeAlbum(albums.first);
    // update();
  }

  Future<void> _pagingPhotos(AssetPathEntity album) async {
    imageList.clear();
    var photos = await album.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    changeSelectedImage(imageList.first);
  }

  changeSelectedImage(AssetEntity image) {
    selectedImage(image);
  }

  void changeAlbum(AssetPathEntity album) async {
    headerTitle(album.name);
    await _pagingPhotos(album);
  }

  void gotoImageFilter() async {
    var file = await selectedImage.value.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);
    Map imagefile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
              title: const Text("Photo Filter Example"),
              image: image!,
              filters: presetFiltersList,
              filename: fileName,
              loader: const Center(child: CircularProgressIndicator()),
              fit: BoxFit.contain,
            ),
      ),
    );
    if (imagefile != null && imagefile.containsKey('image_filtered')) {
      filteredImage = imagefile['image_filtered'];
      Get.to(() => UploadDescription());
    }
  }
}