class FeedModel {
  String id;
  String? title;
  String? feedAuthor;
  String? description;
  int? datetime;
  String? type;
  String? link, cover;
  bool isAlbum;
  int height, width;
  int? views;
  List<Album>? images;

  FeedModel({
    required this.id,
    this.title,
    this.description,
    this.datetime,
    this.type,
    this.link,
    this.isAlbum = false,
    this.images,
    this.cover,
    this.feedAuthor,
    this.height=0,
    this.width=0,
    this.views=0,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        type: json["type"],
        link: json["link"],
        isAlbum: json["is_album"],
        images: json["images"] == null
            ? null
            : List<Album>.from(json["images"].map((x) => Album.fromJson(x))),
        cover: json["cover"],
        feedAuthor: json["account_url"],
        height: json["cover_height"] ?? json["height"],
        width: json["cover_width"] ?? json["width"],
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "datetime": datetime,
        "type": type,
        "link": link,
        "is_album": isAlbum,
        "images": images,
        "cover": cover,
        "account_url": feedAuthor,
      };
}

class Album{
  String? id;
  String? title;
  String? description;
  int? datetime;
  String? type;
  String? link;
  int height, width;

  Album({
    this.id,
    this.title,
    this.description,
    this.datetime,
    this.type,
    this.link,
    this.height=0,
    this.width=0,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        type: json["type"],
        link: json["link"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "datetime": datetime,
        "type": type,
        "link": link,
        "height": height,
      };
}
