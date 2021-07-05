import 'package:english_words_3000/utilities/strings.dart';
import 'package:english_words_3000/view_model/word_view_model.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatefulWidget {
  BaseCard(
    this.valueField,
  );

  final String valueField;

  @override
  _BaseCardState createState() => _BaseCardState();
}

class _BaseCardState extends WordViewModel {
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
                        //todo タップすると日本語訳が表示される
                      });
                    },
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: data.isEmpty
                            ? Center(
                                child: Text(
                                  Strings.nothing,
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : indexNumber < data.length
                                ? Column(children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: SizedBox(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '${data[indexNumber].word}',
                                          //'${data[indexNumber][Strings.valueOfWord]}',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '(${data[indexNumber].wordClass})',
                                          //'(${data[indexNumber][Strings.valueOfWordClass]})',
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
                                //カードを振り分け終えると表示される
                                : Center(
                                    child: Text(
                                      Strings.nothing,
                                      style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
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
                          onTap: () => incrementCounter(
                              widget.valueField, Strings.iDForCanUse),
                          child: Container(
                            // height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink),
                            ),
                            child: Center(
                              child: Text(
                                Strings.canUse,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: () => incrementCounter(
                              widget.valueField, Strings.iDForHaveSeen),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.yellow),
                            ),
                            child: Center(
                              child: Text(
                                Strings.haveSeen,
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
                          onTap: () => incrementCounter(
                              widget.valueField, Strings.iDForCanRead),
                          child: Container(
                            // height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightGreen),
                            ),
                            child: Center(
                              child: Text(
                                Strings.canRead,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: InkWell(
                          onTap: () => incrementCounter(
                              widget.valueField, Strings.iDForNiceToMeetYou),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                            ),
                            child: Center(
                              child: Text(
                                Strings.niceToMeetYou,
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
