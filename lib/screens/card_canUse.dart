import 'package:english_words_3000/screens/base_card.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';

class CanUse extends StatefulWidget {
  @override
  _CanUseState createState() => _CanUseState();
}

class _CanUseState extends State<CanUse> {
  @override
  Widget build(BuildContext context) {
    return BaseCard(Strings.iDForCanUse);
  }
}
