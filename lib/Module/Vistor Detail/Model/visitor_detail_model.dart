// To parse this JSON data, do
//
//     final visitorDetailModel = visitorDetailModelFromJson(jsonString);

import 'dart:convert';

VisitorDetailModel visitorDetailModelFromJson(String str) =>
    VisitorDetailModel.fromJson(json.decode(str));

String visitorDetailModelToJson(VisitorDetailModel data) =>
    json.encode(data.toJson());

class VisitorDetailModel {
  bool? success;
  List<Datum>? data;

  VisitorDetailModel({
    this.success,
    this.data,
  });

  factory VisitorDetailModel.fromJson(Map<String, dynamic> json) =>
      VisitorDetailModel(
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
  int? societyid;
  int? subadminid;
  String? houseaddress;
  String? visitortype;
  String? name;
  String? cnic;
  String? mobileno;
  String? vechileno;
  DateTime? arrivaldate;
  String? arrivaltime;
  DateTime? checkoutdate;
  String? checkouttime;
  int? status;
  String? statusdescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.gatekeeperid,
    this.societyid,
    this.subadminid,
    this.houseaddress,
    this.visitortype,
    this.name,
    this.cnic,
    this.mobileno,
    this.vechileno,
    this.arrivaldate,
    this.arrivaltime,
    this.checkoutdate,
    this.checkouttime,
    this.status,
    this.statusdescription,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        gatekeeperid: json["gatekeeperid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        houseaddress: json["houseaddress"],
        visitortype: json["visitortype"],
        name: json["name"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"] == null
            ? null
            : DateTime.parse(json["arrivaldate"]),
        arrivaltime: json["arrivaltime"],
        checkoutdate: json["checkoutdate"] == null
            ? null
            : DateTime.parse(json["checkoutdate"]),
        checkouttime: json["checkouttime"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gatekeeperid": gatekeeperid,
        "societyid": societyid,
        "subadminid": subadminid,
        "houseaddress": houseaddress,
        "visitortype": visitortype,
        "name": name,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate":
            "${arrivaldate!.year.toString().padLeft(4, '0')}-${arrivaldate!.month.toString().padLeft(2, '0')}-${arrivaldate!.day.toString().padLeft(2, '0')}",
        "arrivaltime": arrivaltime,
        "checkoutdate":
            "${checkoutdate!.year.toString().padLeft(4, '0')}-${checkoutdate!.month.toString().padLeft(2, '0')}-${checkoutdate!.day.toString().padLeft(2, '0')}",
        "checkouttime": checkouttime,
        "status": status,
        "statusdescription": statusdescription,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
