import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  static Future<bool?> loginUserByUid(String uid) async {
    var data = await FirebaseFirestore.instance
      .collection("users")
      .where('uid', isEqualTo: uid)
      .get();
    
    if (data.size == 0) {
      return null;
    } else {
      print(data.docs.first.data());
      return true;
    }
  }
}