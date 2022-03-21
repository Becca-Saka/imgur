class FeedModel {
  String? id;
  String? title;
  String? description;
  int? datetime;
  String? type;
  String? link, cover;
  bool isAlbum;
  int height;
  List<Album>? images;

  FeedModel({
    this.id,
    this.title,
    this.description,
    this.datetime,
    this.type,
    this.link,
    this.isAlbum = false,
    this.images,
    this.cover,
    this.height=0,
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
        height: json["cover_height"] ?? json["height"],
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
      };
}

class Album{
  String? id;
  String? title;
  String? description;
  int? datetime;
  String? type;
  String? link;

  Album({
    this.id,
    this.title,
    this.description,
    this.datetime,
    this.type,
    this.link,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        datetime: json["datetime"],
        type: json["type"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "datetime": datetime,
        "type": type,
        "link": link,
      };
}
