// To parse this JSON data, do
//
//     final noticeBoardModel = noticeBoardModelFromJson(jsonString);

import 'dart:convert';

NoticeBoardModel noticeBoardModelFromJson(String str) =>
    NoticeBoardModel.fromJson(json.decode(str));

String noticeBoardModelToJson(NoticeBoardModel data) =>
    json.encode(data.toJson());

class NoticeBoardModel {
  String? message;
  bool? success;
  List<Datum>? data;

  NoticeBoardModel({
    this.message,
    this.success,
    this.data,
  });

  factory NoticeBoardModel.fromJson(Map<String, dynamic> json) =>
      NoticeBoardModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? noticetitle;
  String? noticedetail;
  DateTime? startdate;
  DateTime? enddate;
  String? starttime;
  String? endtime;
  int? status;
  int? subadminid;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.noticetitle,
    this.noticedetail,
    this.startdate,
    this.enddate,
    this.starttime,
    this.endtime,
    this.status,
    this.subadminid,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        noticetitle: json["noticetitle"],
        noticedetail: json["noticedetail"],
        startdate: json["startdate"] == null
            ? null
            : DateTime.parse(json["startdate"]),
        enddate:
            json["enddate"] == null ? null : DateTime.parse(json["enddate"]),
        starttime: json["starttime"],
        endtime: json["endtime"],
        status: json["status"],
        subadminid: json["subadminid"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "noticetitle": noticetitle,
        "noticedetail": noticedetail,
        "startdate":
            "${startdate!.year.toString().padLeft(4, '0')}-${startdate!.month.toString().padLeft(2, '0')}-${startdate!.day.toString().padLeft(2, '0')}",
        "enddate":
            "${enddate!.year.toString().padLeft(4, '0')}-${enddate!.month.toString().padLeft(2, '0')}-${enddate!.day.toString().padLeft(2, '0')}",
        "starttime": starttime,
        "endtime": endtime,
        "status": status,
        "subadminid": subadminid,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
