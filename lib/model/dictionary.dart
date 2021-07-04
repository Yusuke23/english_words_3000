class Dictionary {
  String iD;
  String word;
  String wordClass;
  String levelOfSpeaking;
  String levelOfWriting;

  Dictionary(
      {this.iD,
      this.word,
      this.wordClass,
      this.levelOfSpeaking,
      this.levelOfWriting});

  Dictionary.fromJson(Map<String, dynamic> json) {
    iD = json['iD'];
    word = json['word'];
    wordClass = json['wordClass'];
    levelOfSpeaking = json['levelOfSpeaking'];
    levelOfWriting = json['levelOfWriting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iD'] = this.iD;
    data['word'] = this.word;
    data['wordClass'] = this.wordClass;
    data['levelOfSpeaking'] = this.levelOfSpeaking;
    data['levelOfWriting'] = this.levelOfWriting;
    return data;
  }
}
