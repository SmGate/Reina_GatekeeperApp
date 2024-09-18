// To parse this JSON data, do
//
//     final preApprovedEntryModel = preApprovedEntryModelFromJson(jsonString);

import 'dart:convert';

PreApprovedEntryModel preApprovedEntryModelFromJson(String str) =>
    PreApprovedEntryModel.fromJson(json.decode(str));

String preApprovedEntryModelToJson(PreApprovedEntryModel data) =>
    json.encode(data.toJson());

class PreApprovedEntryModel {
  bool? success;
  List<Datum>? data;

  PreApprovedEntryModel({
    this.success,
    this.data,
  });

  factory PreApprovedEntryModel.fromJson(Map<String, dynamic> json) =>
      PreApprovedEntryModel(
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
  dynamic name;
  String? description;
  dynamic cnic;
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
  String? firstname;
  String? lastname;
  dynamic email;
  String? address;
  String? password;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  dynamic code;
  int? isVerified;

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
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.password,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.code,
    this.isVerified,
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
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        address: json["address"],
        password: json["password"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        image: json["image"],
        fcmtoken: json["fcmtoken"],
        code: json["code"],
        isVerified: json["is_verified"],
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
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "address": address,
        "password": password,
        "roleid": roleid,
        "rolename": rolename,
        "image": image,
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
      };
}
