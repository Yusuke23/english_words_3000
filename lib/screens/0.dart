import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  List<dynamic> word = [];
  int indexNumber = 0;
  //FirebaseFirestore ID 各種
  String collectionID = 'dictionary';
  String iDForCanUse = 'canUse';
  String iDForCanRead = 'canRead';
  String iDForHaveSeen = 'haveSeen';
  String iDForNiceToMeetYou = 'niceToMeetYou';
  String valueOfWord = 'word';
  String valueOfWordClass = 'wordClass';
  final _firestore = FirebaseFirestore.instance; //firestoreに単語を加える.
  //ユーザーのemail取得
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail;

  void _incrementCounterForCanUse() async {
    setState(() {
      indexNumber++;
      _setPrefItems(); // Shared Preferenceに値を保存する。
      //todo 最後の単語の次は'終わり'を表示する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 1) {
      await _firestore.collection(collectionID).doc(userEmail).set({
        iDForCanUse: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanUse: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  void _incrementCounterForCanRead() async {
    setState(() {
      indexNumber++;
      _setPrefItems(); // Shared Preferenceに値を保存する。
      //todo 最後の単語の次は'終わり'を表示する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 1) {
      await _firestore.collection(collectionID).doc(userEmail).set({
        iDForCanRead: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForCanRead: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  void _incrementCounterForHaveSeen() async {
    setState(() {
      indexNumber++;
      _setPrefItems(); // Shared Preferenceに値を保存する。
      //todo 最後の単語の次は'終わり'を表示する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 1) {
      await _firestore.collection(collectionID).doc(userEmail).set({
        iDForHaveSeen: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForHaveSeen: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  void _incrementCounterForNiceToMeetYou() async {
    setState(() {
      indexNumber++;
      _setPrefItems(); // Shared Preferenceに値を保存する。
      //todo 最後の単語の次は'終わり'を表示する。
    });
    user = _auth.currentUser;
    userEmail = await user.email;
    if (indexNumber == 1) {
      await _firestore.collection(collectionID).doc(userEmail).set({
        iDForNiceToMeetYou: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    } else {
      // arrayUnionを使った更新（要素追加） ※arrayの中がMAP型
      await _firestore.collection(collectionID).doc(userEmail).update({
        iDForNiceToMeetYou: FieldValue.arrayUnion([
          {
            'word': '${word[indexNumber - 1][valueOfWord]}',
            'wordClass': '${word[indexNumber - 1][valueOfWordClass]}',
          },
        ]),
      });
    }
  }

  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      indexNumber = prefs.getInt('counter') ?? 0;
    });
  }

  // Shared Preferenceにデータを書き込む
  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    prefs.setInt('counter', indexNumber);
  }

  void getData() async {
    http.Response response = await http.get(Uri.https(
        'firebasestorage.googleapis.com',
        '/v0/b/english-words-3000-73a27.appspot.com/o/communication_english_words3000.json',
        {'alt': 'media', 'token': 'dcc52d84-7cd9-4bb4-b52f-b66dc02009a3'}));
    if (response.statusCode == 200 && mounted) {
      String data = response.body;
      setState(() {
        word = jsonDecode(data);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    // 初期化時にShared Preferencesに保存している値を読み込む
    _getPrefItems();
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
                        border: Border.all(color: Colors.grey),
                      ),
                      child: word.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(),
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
                                    '${word[indexNumber][valueOfWord]}',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '(${word[indexNumber][valueOfWordClass]})',
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
                      //todo 最後の単語の次は'終わり'を表示する。
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
                          onTap:
                              _incrementCounterForHaveSeen, //カウントアップ + firestoreに表示されているカードの単語加える
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

class Post {
  Post(this.id, this.word, this.wordClass);
  String id;
  String word;
  String wordClass;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'word': word,
      'wordClass': wordClass,
    };
  }
}
