import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String? SEDNERID;
  final String? RECIEVERID;
  final String? TEXT;
  final FieldValue? TIMESTAMP;
  ChatModel({
    this.RECIEVERID,
    this.SEDNERID,
    this.TEXT,
    this.TIMESTAMP
  });

  Map<String, dynamic> toJson() {
    return {
      if (RECIEVERID != null) 'receiverId': RECIEVERID,
      if (SEDNERID != null) 'senderId': SEDNERID,
      if (TEXT != null) 'text': TEXT,
      if (TIMESTAMP != null) 'timestamp': TIMESTAMP,
    };
  }

}
