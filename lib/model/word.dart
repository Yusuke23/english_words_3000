class WordList {
  List<Word> canUse;
  List<Word> canRead;
  List<Word> haveSeen;
  List<Word> niceToMeetYou;

  WordList({this.canUse, this.canRead, this.haveSeen, this.niceToMeetYou});

  WordList.fromJson(Map<String, dynamic> json) {
    if (json['canUse'] != null) {
      canUse = [];
      json['canUse'].forEach((v) {
        canUse.add(Word.fromJson(v));
      });
    }
    if (json['canRead'] != null) {
      canRead = [];
      json['canRead'].forEach((v) {
        canRead.add(Word.fromJson(v));
      });
    }
    if (json['haveSeen'] != null) {
      haveSeen = [];
      json['haveSeen'].forEach((v) {
        haveSeen.add(Word.fromJson(v));
      });
    }
    if (json['niceToMeetYou'] != null) {
      niceToMeetYou = [];
      json['niceToMeetYou'].forEach((v) {
        niceToMeetYou.add(Word.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.canUse != null) {
      data['canUse'] = this.canUse.map((v) => v.toJson()).toList();
    }
    if (this.canRead != null) {
      data['canRead'] = this.canRead.map((v) => v.toJson()).toList();
    }
    if (this.haveSeen != null) {
      data['haveSeen'] = this.haveSeen.map((v) => v.toJson()).toList();
    }
    if (this.niceToMeetYou != null) {
      data['niceToMeetYou'] =
          this.niceToMeetYou.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Word {
  String word;
  String wordClass;

  Word({this.word, this.wordClass});

  Word.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    wordClass = json['wordClass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['word'] = this.word;
    data['wordClass'] = this.wordClass;
    return data;
  }
}

// [
// {"canUse" : [
// {
// "word": "a",
// "wordClass": "indefinite article determiner"
// },
// {
// "word": "abandon",
// "wordClass": "v"
// }]},
// {"canRead" : [
// {
// "word": "a",
// "wordClass": "indefinite article determiner"
// },
// {
// "word": "abandon",
// "wordClass": "v"
// }]},
// {"haveseen" : [
// {
// "word": "a",
// "wordClass": "indefinite article determiner"
// },
// {
// "word": "abandon",
// "wordClass": "v"
// }]},
// {"niceToMeetYou" : [
// {
// "word": "a",
// "wordClass": "indefinite article determiner"
// },
// {
// "word": "abandon",
// "wordClass": "v"
// }]}
// ]
