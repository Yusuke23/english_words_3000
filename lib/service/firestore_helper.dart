import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firestore extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance; //firestoreに単語を加える.
  final _auth = FirebaseAuth.instance;
  //ユーザーのemail取得
  dynamic user;
  String userEmail;

  void updateWordData(
      String valueRemove, String valueUnion, List data, int indexNumber) async {
    user = _auth.currentUser;
    userEmail = await user.email;
    //delete処理
    await _firestore.collection(Strings.collectionID).doc(userEmail).update({
      valueRemove: FieldValue.arrayRemove([
        {
          Strings.valueOfWord: '${data[indexNumber - 1][Strings.valueOfWord]}',
          Strings.valueOfWordClass:
              '${data[indexNumber - 1][Strings.valueOfWordClass]}',
        },
      ]),
    });
    // 要素追加 ※arrayの中がMAP型
    await _firestore.collection(Strings.collectionID).doc(userEmail).update({
      valueUnion: FieldValue.arrayUnion([
        {
          Strings.valueOfWord: '${data[indexNumber - 1][Strings.valueOfWord]}',
          Strings.valueOfWordClass:
              '${data[indexNumber - 1][Strings.valueOfWordClass]}',
        },
      ]),
    });
  }
}
