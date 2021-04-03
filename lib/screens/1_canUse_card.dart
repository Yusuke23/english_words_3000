import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  //カードの中身がラスト１単語の場合使用される
  String emptyCard;
  //ユーザーのemail取得
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  void _incrementCounterForCanUse() async {
    setState(() {
      if (indexNumber < dataLength &&
          indexNumber != dataLength - 1 &&
          emptyCard != 'empty') {
        indexNumber++;
      }
      //カードの中身がラスト１単語の場合使用される
      else if (indexNumber == dataLength - 1) {
        indexNumber = 0;
      }
      _setPrefItems(); // Shared Preferenceに値を保存する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 0) {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayUnion([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
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
    setState(() {
      if (indexNumber < dataLength &&
          indexNumber != dataLength - 1 &&
          emptyCard != 'empty') {
        indexNumber++;
      }
      //カードの中身がラスト１単語の場合使用される
      else if (indexNumber == dataLength - 1) {
        indexNumber = 0;
        emptyCard = 'empty';
      }
      _setPrefItems(); // Shared Preferenceに値を保存する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 0 || emptyCard == 'empty') {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanRead: FieldValue.arrayUnion([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
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
    setState(() {
      if (indexNumber < dataLength &&
          indexNumber != dataLength - 1 &&
          emptyCard != 'empty') {
        indexNumber++;
      }
      //カードの中身がラスト１単語の場合使用される
      else if (indexNumber == dataLength - 1) {
        indexNumber = 0;
        emptyCard = 'empty';
      }
      _setPrefItems(); // Shared Preferenceに値を保存する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 0 || emptyCard == 'empty') {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForHaveSeen: FieldValue.arrayUnion([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
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
    setState(() {
      if (indexNumber < dataLength &&
          indexNumber != dataLength - 1 &&
          emptyCard != 'empty') {
        indexNumber++;
      }
      //カードの中身がラスト１単語の場合使用される
      else if (indexNumber == dataLength - 1) {
        indexNumber = 0;
        emptyCard = 'empty';
      }
      _setPrefItems(); // Shared Preferenceに値を保存する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 0 || emptyCard == 'empty') {
      //deletes処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForNiceToMeetYou: FieldValue.arrayUnion([
          {
            'word': '${data[dataLength - 1][valueOfWord]}',
            'wordClass': '${data[dataLength - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      //delete処理
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayRemove([
          {
            'word': '${data[indexNumber - 1][valueOfWord]}',
            'wordClass': '${data[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
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

  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    if (mounted) {
      setState(() {
        indexNumber = prefs.getInt('counterForCanUse') ?? 0;
      });
    }
  }

  // Shared Preferenceにデータを書き込む
  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    prefs.setInt('counterForCanUse', indexNumber);
  }

  // LoadボタンがおされたらFirestoreの値を取得
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
    // 初期化時にShared Preferencesに保存している値を読み込む
    _getPrefItems();
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
                        //タップすると日本語訳が表示される
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
                          //カードの中身がラスト１単語の場合使用される
                          : (indexNumber == 0 && emptyCard == 'empty')
                              ? Center(
                                  child: Text(
                                    '空',
                                    style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Column(children: <Widget>[
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
                                ]),
                    ),
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
                                '見たこ',
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
