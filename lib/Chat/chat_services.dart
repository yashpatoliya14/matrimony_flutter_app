import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matrimony_flutter/Chat/chat_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String getChatId(String uid1, String uid2) {
    return uid1.compareTo(uid2) < 0 ? '$uid1\_$uid2' : '$uid2\_$uid1';
  }

  Stream<QuerySnapshot> getMessages(String receiverId) {
    final userId = auth.currentUser!.uid;

    String chatId = getChatId(userId, receiverId);

    return _firestore
        .collection('messages')
        .doc(chatId)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots();
  }

  Future<void> sendMessage(String receiverId, String text) async {
  final senderId = auth.currentUser!.uid;
  String chatId = getChatId(senderId, receiverId);

  ChatModel chatModel = ChatModel(
    SEDNERID: senderId,
    RECIEVERID: receiverId,
    TEXT: text,
    TIMESTAMP: FieldValue.serverTimestamp(),
  );

  // ✅ Save to structured subcollection only
  await _firestore
      .collection('messages')
      .doc(chatId)
      .collection('chats')
      .add(chatModel.toJson());
}

}
