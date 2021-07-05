import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words_3000/model/word.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  void updateWordData(String valueRemove, String valueUnion, List<Word> data,
      int indexNumber) async {
    user = _auth.currentUser;
    userEmail = await user.email;
    //delete処理
    await _firestore.collection(Strings.collectionID).doc(userEmail).update({
      valueRemove: FieldValue.arrayRemove([
        {
          Strings.valueOfWord: '${data[indexNumber - 1].word}',
          Strings.valueOfWordClass: '${data[indexNumber - 1].wordClass}',
        },
      ]),
    });
    // 要素追加 ※arrayの中がMAP型
    await _firestore.collection(Strings.collectionID).doc(userEmail).update({
      valueUnion: FieldValue.arrayUnion([
        {
          Strings.valueOfWord: '${data[indexNumber - 1].word}',
          Strings.valueOfWordClass: '${data[indexNumber - 1].wordClass}',
        },
      ]),
    });
  }
}
