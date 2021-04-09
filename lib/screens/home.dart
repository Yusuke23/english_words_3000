import 'package:flutter/material.dart';
import '0_top_card.dart';
import '1_canUse_card.dart';
import '2_canRead_card.dart';
import '3_haveSeen_card.dart';
import '4_niceToMeetYou_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static const id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // ページ切り替え用のコントローラを定義
  PageController _pageController;

  // ページインデックス保存用
  int _screen = 0;

  //appbarに表示される達成度計算用
  int wordLength;
  int indexNumber = 0;
  List<dynamic> word = [];
  int isDone;

  @override
  void initState() {
    super.initState();
    // コントローラ作成
    _pageController = PageController(
      initialPage: _screen, // 初期ページの指定。上記で_screenを１とすれば２番目のページが初期表示される。
    );
    getData();
    _getPrefItems();
  }

  @override
  void dispose() {
    // コントローラ破棄
    _pageController.dispose();
    super.dispose();
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
    }
  }

  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      indexNumber = prefs.getInt('counter') ?? 0;
    });
  }

  //達成度の計算
  double calc(int wordLength, int isDone) {
    return (wordLength - (isDone)) / wordLength * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: calc(word.length, indexNumber).isInfinite
            ? Text('がんばろう！！')
            : Text(
                '達成度:　${calc(word.length, word.length - indexNumber).toStringAsFixed(2)}%'),
        //todo タップすると達成度が更新されるようにする。
      ),
      body: PageView(
          controller: _pageController,
          // ページ切り替え時に実行する処理
          // 以下ではページインデックスをindexとする
          onPageChanged: (index) {
            setState(() {
              // ページインデックスを更新
              _screen = index;
            });
          },
          // ページ下部のナビゲーションメニューに相当する各ページビュー。
          children: [
            Top(),
            CanUse(),
            CanRead(),
            HaveSeen(),
            NiceToMeetYou(),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        // 現在のページインデックス
        currentIndex: _screen,
        // onTapでナビゲーションメニューがタップされた時の処理を定義
        onTap: (index) {
          setState(() {
            // ページインデックスを更新
            _screen = index;

            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeOut);
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'トップ',
            icon: Icon(Icons.sentiment_very_satisfied_outlined),
          ),
          BottomNavigationBarItem(
            label: '使える',
            icon: Icon(Icons.sentiment_satisfied_outlined),
          ),
          BottomNavigationBarItem(
            label: '読める',
            icon: Icon(Icons.sentiment_satisfied_alt_rounded),
          ),
          BottomNavigationBarItem(
            label: '見たことある',
            icon: Icon(Icons.sentiment_neutral_outlined),
          ),
          BottomNavigationBarItem(
            label: '初めて',
            icon: Icon(Icons.sentiment_neutral_outlined),
          ),
        ],
      ),
    );
  }
}
