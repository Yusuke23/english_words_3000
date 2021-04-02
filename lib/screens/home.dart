import 'package:flutter/material.dart';
import '0.dart';
import '1.dart';
import '2.dart';
import '3.dart';
import '4.dart';

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

  @override
  void initState() {
    super.initState();
    // コントローラ作成
    _pageController = PageController(
      initialPage: _screen, // 初期ページの指定。上記で_screenを１とすれば２番目のページが初期表示される。
    );
  }

  @override
  void dispose() {
    // コントローラ破棄
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('English 3000'),
      ),
      body: PageView(
          controller: _pageController,
          // ページ切り替え時に実行する処理
          // PageViewのonPageChangedはページインデックスを受け取る
          // 以下ではページインデックスをindexとする
          onPageChanged: (index) {
            setState(() {
              // ページインデックスを更新
              _screen = index;
            });
          },
          // ページ下部のナビゲーションメニューに相当する各ページビュー。後述
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

            // ページ遷移を定義。
            // curveで指定できるのは以下
            // https://api.flutter.dev/flutter/animation/Curves-class.html
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
