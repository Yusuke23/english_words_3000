import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_card.dart';

class CanRead extends StatefulWidget {
  @override
  _CanReadState createState() => _CanReadState();
}

class _CanReadState extends State<CanRead> {
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
          data = ds[Strings.iDForCanRead];
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
          dataLength = ds[Strings.iDForCanRead].length;
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
    return BaseCard(data, dataLength, indexNumber, Strings.iDForCanRead);
  }
}
