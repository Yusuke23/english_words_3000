import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words_3000/model/word.dart';
import 'package:english_words_3000/screens/base_card.dart';
import 'package:english_words_3000/service/firestore_helper.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class WordViewModel extends State<BaseCard> {
  List<Word> data = [];
  int indexNumber = 0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  @override
  void initState() {
    super.initState();
    callItems();
  }

  Future<void> callItems() async {
    await load();
  }

  // Firestoreの値を取得
  Future<void> load() async {
    user = _auth.currentUser;
    userEmail = await user.email;
    await _firestore
        .collection(Strings.collectionID)
        .doc(userEmail)
        .get()
        .then((DocumentSnapshot ds) {
      if (mounted && ds.exists) {
        //if (ds is List)
        setState(() {
          //data = ds[widget.valueField];
          data = ds[widget.valueField]
              .map((e) => Word.fromJson(e))
              .toList()
              .cast<Word>();
        });
      }
    });
  }

  //表示する単語を指示 & アップデート
  void incrementCounter(String valueRemove, String valueUnion) async {
    if (indexNumber < data.length) {
      setState(() {
        indexNumber++;
      });
    }
    Firestore().updateWordData(valueRemove, valueUnion, data, indexNumber);
  }
}
