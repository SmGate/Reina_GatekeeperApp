// To parse this JSON data, do
//
//     final preApprovedGuestModel = preApprovedGuestModelFromJson(jsonString);

import 'dart:convert';

PreApprovedGuestModel preApprovedGuestModelFromJson(String str) =>
    PreApprovedGuestModel.fromJson(json.decode(str));

String preApprovedGuestModelToJson(PreApprovedGuestModel data) =>
    json.encode(data.toJson());

class PreApprovedGuestModel {
  bool? success;
  List<Datum>? data;

  PreApprovedGuestModel({
    this.success,
    this.data,
  });

  factory PreApprovedGuestModel.fromJson(Map<String, dynamic> json) =>
      PreApprovedGuestModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? gatekeeperid;
  int? userid;
  String? visitortype;
  String? name;
  String? description;
  String? cnic;
  String? mobileno;
  String? vechileno;
  DateTime? arrivaldate;
  String? arrivaltime;
  int? status;
  String? statusdescription;
  dynamic checkintime;
  dynamic checkouttime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic fromDate;
  dynamic toDate;

  Datum({
    this.id,
    this.gatekeeperid,
    this.userid,
    this.visitortype,
    this.name,
    this.description,
    this.cnic,
    this.mobileno,
    this.vechileno,
    this.arrivaldate,
    this.arrivaltime,
    this.status,
    this.statusdescription,
    this.checkintime,
    this.checkouttime,
    this.createdAt,
    this.updatedAt,
    this.fromDate,
    this.toDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gatekeeperid: json["gatekeeperid"],
        userid: json["userid"],
        visitortype: json["visitortype"],
        name: json["name"],
        description: json["description"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"] == null
            ? null
            : DateTime.parse(json["arrivaldate"]),
        arrivaltime: json["arrivaltime"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        checkintime: json["checkintime"],
        checkouttime: json["checkouttime"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fromDate: json["from_date"],
        toDate: json["to_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gatekeeperid": gatekeeperid,
        "userid": userid,
        "visitortype": visitortype,
        "name": name,
        "description": description,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate":
            "${arrivaldate!.year.toString().padLeft(4, '0')}-${arrivaldate!.month.toString().padLeft(2, '0')}-${arrivaldate!.day.toString().padLeft(2, '0')}",
        "arrivaltime": arrivaltime,
        "status": status,
        "statusdescription": statusdescription,
        "checkintime": checkintime,
        "checkouttime": checkouttime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "from_date": fromDate,
        "to_date": toDate,
      };
}
