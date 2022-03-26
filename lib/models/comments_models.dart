class CommentsModel{
  int points;
  int commentCount;
  int datetime;
  String comments;
  String author;

  CommentsModel({
    required this.points,
    required this.commentCount,
    required this.datetime,
    required this.comments,
    required this.author,
  });


  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        points: json["points"],
        commentCount: json["children"].length,
        datetime: json["datetime"],
        comments: json["comments"],
        author: json["author"],

  );

  Map<String, dynamic> toJson() => {
        "points": points,
        "comment_count": commentCount,
        "datetime": datetime,
        "comments": comments,
        "author": author,
  };

}