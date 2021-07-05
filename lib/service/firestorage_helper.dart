import 'package:english_words_3000/model/dictionary.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorage {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  void addWordData(
      String value, List<Dictionary> dictionary, int indexNumber) async {
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 1) {
      await _firestore.collection(Strings.collectionID).doc(userEmail).set({
        value: FieldValue.arrayUnion([
          {
            Strings.valueOfWord: '${dictionary[indexNumber - 1].word}',
            Strings.valueOfWordClass:
                '${dictionary[indexNumber - 1].wordClass}',
          },
        ]),
      });
    } else {
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(Strings.collectionID).doc(userEmail).update({
        value: FieldValue.arrayUnion([
          {
            Strings.valueOfWord: '${dictionary[indexNumber - 1].word}',
            Strings.valueOfWordClass:
                '${dictionary[indexNumber - 1].wordClass}',
          },
        ]),
      });
    }
  }
}
