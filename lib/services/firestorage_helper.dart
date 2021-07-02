import 'package:english_words_3000/utilities/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorage {
  final _firestore = FirebaseFirestore.instance; //firestoreに単語を加える.
  //ユーザーのemail取得
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  void addWordData(String value, List<dynamic> word, int indexNumber) async {
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 1) {
      await _firestore.collection(Strings.collectionID).doc(userEmail).set({
        value: FieldValue.arrayUnion([
          {
            Strings.valueOfWord:
                '${word[indexNumber - 1][Strings.valueOfWord]}',
            Strings.valueOfWordClass:
                '${word[indexNumber - 1][Strings.valueOfWordClass]}',
          },
        ]),
      });
    } else {
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(Strings.collectionID).doc(userEmail).update({
        value: FieldValue.arrayUnion([
          {
            Strings.valueOfWord:
                '${word[indexNumber - 1][Strings.valueOfWord]}',
            Strings.valueOfWordClass:
                '${word[indexNumber - 1][Strings.valueOfWordClass]}',
          },
        ]),
      });
    }
  }
}
