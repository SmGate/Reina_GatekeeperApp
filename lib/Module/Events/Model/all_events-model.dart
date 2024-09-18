// To parse this JSON data, do
//
//     final allEventsModel = allEventsModelFromJson(jsonString);

import 'dart:convert';

AllEventsModel allEventsModelFromJson(String str) =>
    AllEventsModel.fromJson(json.decode(str));

String allEventsModelToJson(AllEventsModel data) => json.encode(data.toJson());

class AllEventsModel {
  List<Datum>? data;

  AllEventsModel({
    this.data,
  });

  factory AllEventsModel.fromJson(Map<String, dynamic> json) => AllEventsModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? userid;
  String? title;
  String? description;
  DateTime? startdate;
  DateTime? enddate;
  String? starttime;
  String? endtime;
  int? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Image>? images;

  Datum({
    this.id,
    this.userid,
    this.title,
    this.description,
    this.startdate,
    this.enddate,
    this.starttime,
    this.endtime,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userid: json["userid"],
        title: json["title"],
        description: json["description"],
        startdate: json["startdate"] == null
            ? null
            : DateTime.parse(json["startdate"]),
        enddate:
            json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        starttime: json["starttime"],
        endtime: json["endtime"],
        active: json["active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "title": title,
        "description": description,
        "startdate":
            "${startdate!.year.toString().padLeft(4, '0')}-${startdate!.month.toString().padLeft(2, '0')}-${startdate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate!.year.toString().padLeft(4, '0')}-${enddate!.month.toString().padLeft(2, '0')}-${enddate!.day.toString().padLeft(2, '0')}",
        "starttime": starttime,
        "endtime": endtime,
        "active": active,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  int? id;
  int? eventid;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Image({
    this.id,
    this.eventid,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        eventid: json["eventid"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eventid": eventid,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
