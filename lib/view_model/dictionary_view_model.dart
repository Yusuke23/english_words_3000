import 'dart:convert';
import 'package:english_words_3000/model/dictionary.dart';
import 'package:english_words_3000/screens/card_top.dart';
import 'package:english_words_3000/service/firestorage_helper.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class DictionaryViewModel extends State<Top> {
  List<Dictionary> dictionary = [];
  int indexNumber = 0;

  @override
  void initState() {
    super.initState();
    callItems();
    _getPrefItems();
  }

  Future<void> callItems() async {
    await _fetchDictionaryData();
  }

  Future<void> _fetchDictionaryData() async {
    final http.Response response = await http.get(Uri.https(
        Strings.url,
        Strings.jsonFile,
        {Strings.alt: Strings.altValue, Strings.token: Strings.tokenValue}));
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody is List)
        setState(() {
          dictionary = jsonBody.map((e) => Dictionary.fromJson(e)).toList();
        });
    } else {
      throw Exception('Can\'t get dictionary');
    }
  }

  //単語を各Fieldに割り振る
  void incrementCounter(String value) async {
    setState(() {
      if (indexNumber < dictionary.length) {
        indexNumber++;
        _setPrefItems(); //Shared Preferenceに値を保存する。
      }
    });
    FirebaseStorage().addWordData(value, dictionary, indexNumber);
  }

  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    setState(() {
      indexNumber = prefs.getInt(Strings.SHARED_PREFERENCE_KEY) ?? 0;
    });
  }

  // Shared Preferenceにデータを書き込む
  _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。
    prefs.setInt(Strings.SHARED_PREFERENCE_KEY, indexNumber);
  }
}
