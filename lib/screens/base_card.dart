import 'package:english_words_3000/services/firestore_helper.dart';
import 'package:english_words_3000/utilities/strings.dart';
import 'package:flutter/material.dart';

class BaseCard extends StatefulWidget {
  BaseCard(
    this.data,
    this.dataLength,
    this.indexNumber,
    this.valueRemove,
  );

  final List<dynamic> data;
  final int dataLength;
  int indexNumber;
  final String valueRemove;

  @override
  _BaseCardState createState() => _BaseCardState();
}

class _BaseCardState extends State<BaseCard> {
  //ユーザーのemail取得
  dynamic user;
  String userEmail;

  //表示する単語を指示 & アップデート
  void _incrementCounter(String valueRemove, String valueUnion) async {
    if (widget.indexNumber < widget.dataLength) {
      setState(() {
        widget.indexNumber++;
      });
    }
    Firestore().updateWordData(
        valueRemove, valueUnion, widget.data, widget.indexNumber);
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
                        //todo タップすると日本語訳が表示される
                      });
                    },
                    child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: widget.data.isEmpty
                            ? Center(
                                child: Text(
                                  Strings.nothing,
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : widget.indexNumber < widget.dataLength
                                ? Column(children: <Widget>[
                                    Expanded(
                                      child: Center(
                                        child: SizedBox(),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '${widget.data[widget.indexNumber][Strings.valueOfWord]}',
                                          style: TextStyle(
                                            fontSize: 30.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          '(${widget.data[widget.indexNumber][Strings.valueOfWordClass]})',
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
                          onTap: () => _incrementCounter(
                              widget.valueRemove, Strings.iDForCanUse),
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
                          onTap: () => _incrementCounter(
                              widget.valueRemove, Strings.iDForHaveSeen),
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
                          onTap: () => _incrementCounter(
                              widget.valueRemove, Strings.iDForCanRead),
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
                          onTap: () => _incrementCounter(
                              widget.valueRemove, Strings.iDForNiceToMeetYou),
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
