import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';
import 'base_card.dart';

class NiceToMeetYou extends StatefulWidget {
  @override
  _NiceToMeetYouState createState() => _NiceToMeetYouState();
}

class _NiceToMeetYouState extends State<NiceToMeetYou> {
  @override
  Widget build(BuildContext context) {
    return BaseCard(Strings.iDForNiceToMeetYou);
  }
}
