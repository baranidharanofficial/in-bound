import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ChatService extends ChangeNotifier {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendConnectionRequest(String receiverId, String message) async {
    await _firestore
        .collection('connect_rooms')
        .doc(receiverId)
        .collection('requests')
        .add({'id': 'Connection Request'});
  }

  Stream<QuerySnapshot> getConnectionRequest(String userId) {
    print(userId);

    return _firestore
        .collection('connect_rooms')
        .doc(userId)
        .collection('requests')
        .snapshots();
  }

  Future<DocumentSnapshot> getUserInfo(String userId) async {
    print(userId);

    return await _firestore.collection('users').doc(userId).get();
  }
}
