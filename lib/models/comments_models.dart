class CommentsModel{
  int points;
  int commentCount;
  int datetime;
  String comment;
  String author;

  CommentsModel({
    required this.points,
    required this.commentCount,
    required this.datetime,
    required this.comment,
    required this.author,
  });


  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        points: json["points"],
        commentCount: json["children"].length,
        datetime: json["datetime"],
        comment: json["comment"],
        author: json["author"],

  );

  Map<String, dynamic> toJson() => {
        "points": points,
        "comment_count": commentCount,
        "datetime": datetime,
        "comments": comment,
        "author": author,
  };

}