// To parse this JSON data, do
//
//     final updatePreApprovedEntryStatusModel = updatePreApprovedEntryStatusModelFromJson(jsonString);

import 'dart:convert';

UpdatePreApprovedEntryStatusModel updatePreApprovedEntryStatusModelFromJson(
        String str) =>
    UpdatePreApprovedEntryStatusModel.fromJson(json.decode(str));

String updatePreApprovedEntryStatusModelToJson(
        UpdatePreApprovedEntryStatusModel data) =>
    json.encode(data.toJson());

class UpdatePreApprovedEntryStatusModel {
  bool? success;
  Data? data;
  String? message;

  UpdatePreApprovedEntryStatusModel({
    this.success,
    this.data,
    this.message,
  });

  factory UpdatePreApprovedEntryStatusModel.fromJson(
          Map<String, dynamic> json) =>
      UpdatePreApprovedEntryStatusModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
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
  String? checkintime;
  dynamic checkouttime;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic fromDate;
  dynamic toDate;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
