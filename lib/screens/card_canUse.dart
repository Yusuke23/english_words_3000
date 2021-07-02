import 'package:english_words_3000/screens/base_card.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CanUse extends StatefulWidget {
  @override
  _CanUseState createState() => _CanUseState();
}

class _CanUseState extends State<CanUse> {
  List data = [];
  int dataLength;
  int indexNumber = 0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  // Firestoreの値を取得
  void load() async {
    user = _auth.currentUser;
    userEmail = await user.email;
    await _firestore
        .collection(Strings.collectionID)
        .doc(userEmail)
        .get()
        .then((DocumentSnapshot ds) {
      if (mounted && ds.exists) {
        setState(() {
          data = ds[Strings.iDForCanUse];
        });
      }
    });
  }

  void loadDataLength() async {
    user = _auth.currentUser;
    userEmail = await user.email;
    await _firestore
        .collection(Strings.collectionID)
        .doc(userEmail)
        .get()
        .then((DocumentSnapshot ds) {
      if (mounted && ds.exists) {
        setState(() {
          dataLength = ds[Strings.iDForCanUse].length;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    load();
    loadDataLength();
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(data, dataLength, indexNumber, Strings.iDForCanUse);
  }
}
