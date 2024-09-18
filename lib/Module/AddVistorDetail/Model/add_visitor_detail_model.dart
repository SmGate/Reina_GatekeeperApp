// To parse this JSON data, do
//
//     final addVisitorDetailModel = addVisitorDetailModelFromJson(jsonString);

import 'dart:convert';

AddVisitorDetailModel addVisitorDetailModelFromJson(String str) =>
    AddVisitorDetailModel.fromJson(json.decode(str));

String addVisitorDetailModelToJson(AddVisitorDetailModel data) =>
    json.encode(data.toJson());

class AddVisitorDetailModel {
  bool? success;
  Data? data;

  AddVisitorDetailModel({
    this.success,
    this.data,
  });

  factory AddVisitorDetailModel.fromJson(Map<String, dynamic> json) =>
      AddVisitorDetailModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  int? gatekeeperid;
  int? societyid;
  int? subadminid;
  String? houseaddress;
  String? visitortype;
  String? name;
  String? cnic;
  String? mobileno;
  String? vechileno;
  String? arrivaldate;
  String? arrivaltime;
  String? checkoutdate;
  String? checkouttime;
  int? status;
  String? statusdescription;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
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
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gatekeeperid: json["gatekeeperid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        houseaddress: json["houseaddress"],
        visitortype: json["visitortype"],
        name: json["name"],
        cnic: json["cnic"],
        mobileno: json["mobileno"],
        vechileno: json["vechileno"],
        arrivaldate: json["arrivaldate"],
        arrivaltime: json["arrivaltime"],
        checkoutdate: json["checkoutdate"],
        checkouttime: json["checkouttime"],
        status: json["status"],
        statusdescription: json["statusdescription"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "gatekeeperid": gatekeeperid,
        "societyid": societyid,
        "subadminid": subadminid,
        "houseaddress": houseaddress,
        "visitortype": visitortype,
        "name": name,
        "cnic": cnic,
        "mobileno": mobileno,
        "vechileno": vechileno,
        "arrivaldate": arrivaldate,
        "arrivaltime": arrivaltime,
        "checkoutdate": checkoutdate,
        "checkouttime": checkouttime,
        "status": status,
        "statusdescription": statusdescription,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
