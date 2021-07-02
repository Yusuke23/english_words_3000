import 'package:english_words_3000/services/firestorage_helper.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  List<dynamic> word = [];
  int indexNumber = 0;
  final _firestore = FirebaseFirestore.instance; //firestoreに単語を加える.
  //ユーザーのemail取得
  dynamic user;
  String userEmail;

  //単語を各Fieldに割り振る
  void _incrementCounter(String value) async {
    setState(() {
      if (indexNumber < word.length) {
        indexNumber++;
        _setPrefItems(); //Shared Preferenceに値を保存する。
      }
    });
    FirebaseStorage().addWordData(value, word, indexNumber);
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
                            : indexNumber < word.length
                                ? Column(children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: SizedBox(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '${word[indexNumber][Strings.valueOfWord]}',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '(${word[indexNumber][Strings.valueOfWordClass]})',
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
                                : Expanded(
                                    child: Center(
                                      child: Text(
                                        '達成！！！！',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
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
                          onTap: () => _incrementCounter(Strings.iDForCanUse),
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
                          onTap: () => _incrementCounter(Strings
                              .iDForHaveSeen), //カウントアップ + firestoreに表示されているカードの単語加える
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
                          onTap: () => _incrementCounter(Strings.iDForCanRead),
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
                          onTap: () =>
                              _incrementCounter(Strings.iDForNiceToMeetYou),
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
