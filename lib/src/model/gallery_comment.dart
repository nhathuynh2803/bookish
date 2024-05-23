import 'package:html/dom.dart';

import 'base_model.dart';

class GalleryComment extends Model<GalleryComment> {
  int id;
  String? username;
  int? userId;
  String score;
  List<String> scoreDetails;
  Element content;
  String time;
  String? lastEditTime;
  bool fromMe;
  bool votedUp;
  bool votedDown;

  GalleryComment({
    required this.id,
    this.username,
    this.userId,
    required this.score,
    required this.scoreDetails,
    required this.content,
    required this.time,
    this.lastEditTime,
    required this.fromMe,
    required this.votedUp,
    required this.votedDown,
  });

  @override
  String toString() {
    return 'GalleryComment{id: $id, username: $username, userId: $userId, score: $score, scoreDetails: $scoreDetails, content: $content, time: $time, lastEditTime: $lastEditTime, fromMe: $fromMe, votedUp: $votedUp, votedDown: $votedDown}';
  }
  
  @override
  GalleryComment fromJson(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    userId = map['userId'];
    score = map['score'];
    scoreDetails = List<String>.from(map['scoreDetails']);
    content = map['content'];
    time = map['time'];
    lastEditTime = map['lastEditTime'];
    fromMe = map['fromMe'];
    votedUp = map['votedUp'];
    votedDown = map['votedDown'];
    return this;
  }
  
  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['userId'] = userId;
    data['score'] = score;
    data['scoreDetails'] = scoreDetails;
    data['content'] = content;
    data['time'] = time;
    data['lastEditTime'] = lastEditTime;
    data['fromMe'] = fromMe;
    data['votedUp'] = votedUp;
    data['votedDown'] = votedDown;
    return data;
  }
}
