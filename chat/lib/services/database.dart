import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethoda {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByEmail(String userEmail) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: userEmail)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection('ChatRoom')
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e);
    });
  }
}
