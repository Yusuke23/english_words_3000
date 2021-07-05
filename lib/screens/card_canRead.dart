import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'base_card.dart';

class CanRead extends StatefulWidget {
  @override
  _CanReadState createState() => _CanReadState();
}

class _CanReadState extends State<CanRead> {
  @override
  Widget build(BuildContext context) {
    return BaseCard(Strings.iDForCanRead);
  }
}
