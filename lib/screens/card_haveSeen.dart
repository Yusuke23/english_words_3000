import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'base_card.dart';

class HaveSeen extends StatefulWidget {
  @override
  _HaveSeenState createState() => _HaveSeenState();
}

class _HaveSeenState extends State<HaveSeen> {
  @override
  Widget build(BuildContext context) {
    return BaseCard(Strings.iDForHaveSeen);
  }
}
