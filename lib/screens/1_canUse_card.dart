import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CanUse extends StatefulWidget {
  @override
  _CanUseState createState() => _CanUseState();
}

class _CanUseState extends State<CanUse> {
  List data = [];
  int dataLength; //fieldValue length
  int indexNumber = 0;
  //FirebaseFirestore ID 各種
  String collectionID = 'dictionary';
  String valueOfWord = 'word';
  String valueOfWordClass = 'wordClass';
  final _firestore = FirebaseFirestore.instance; //firestoreに単語を加える.
  String iDForCanUse = 'canUse';
  String iDForCanRead = 'canRead';
  String iDForHaveSeen = 'haveSeen';
  String iDForNiceToMeetYou = 'niceToMeetYou';
  //ユーザーのemail取得
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  void _incrementCounterForCanUse() async {
    if (indexNumber < dataLength) {
      setState(() {
        indexNumber++;
      });
      user = _auth.currentUser;
      userEmail = await user.email;
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // 要素追加 ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayUnion([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  void _incrementCounterForCanRead() async {
    if (indexNumber < dataLength) {
      setState(() {
        indexNumber++;
      });
      user = _auth.currentUser;
      userEmail = await user.email;
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // 要素追加 ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanRead: FieldValue.arrayUnion([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  void _incrementCounterForHaveSeen() async {
    if (indexNumber < dataLength) {
      setState(() {
        indexNumber++;
      });
      user = _auth.currentUser;
      userEmail = await user.email;
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // 要素追加 ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForHaveSeen: FieldValue.arrayUnion([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  void _incrementCounterForNiceToMeetYou() async {
    if (indexNumber < dataLength) {
      setState(() {
        indexNumber++;
      });
      user = _auth.currentUser;
      userEmail = await user.email;
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // 要素追加 ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForNiceToMeetYou: FieldValue.arrayUnion([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  // Firestoreの値を取得
  void load() async {
    user = _auth.currentUser;
    userEmail = await user.email;
    await _firestore
        .collection(collectionID)
        .doc(userEmail)
        .get()
        .then((DocumentSnapshot ds) {
      if (mounted && ds.exists) {
        setState(() {
          data = ds[iDForCanUse];
        });
      }
    });
  }

  void loadDataLength() async {
    user = _auth.currentUser;
    userEmail = await user.email;
    await _firestore
        .collection(collectionID)
        .doc(userEmail)
        .get()
        .then((DocumentSnapshot ds) {
      if (mounted && ds.exists) {
        setState(() {
          dataLength = ds[iDForCanUse].length;
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 50,
          top: 110,
          right: 50,
          bottom: 50,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        //todo タップすると日本語訳が表示される
                      });
                    },
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink),
                        ),
                        child: data.isEmpty
                            ? Center(
                                child: Text(
                                  '空',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : indexNumber < dataLength
                                ? Column(children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: SizedBox(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '${data[indexNumber][valueOfWord]}',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '(${data[indexNumber][valueOfWordClass]})',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: SizedBox(),
                                      ),
                                    ),
                                  ])
                                //カードを振り分け終えると表示される
                                : Center(
                                    child: Text(
                                      '空',
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: _incrementCounterForCanUse,
                          child: Container(
                            // height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink),
                            ),
                            child: Center(
                              child: Text(
                                '使える',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: _incrementCounterForHaveSeen,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.yellow),
                            ),
                            child: Center(
                              child: Text(
                                '見たことある',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: _incrementCounterForCanRead,
                          child: Container(
                            // height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightGreen),
                            ),
                            child: Center(
                              child: Text(
                                '読める',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: _incrementCounterForNiceToMeetYou,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text(
                                '初めて',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
