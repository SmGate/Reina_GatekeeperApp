// To parse this JSON data, do
//
//     final updateVisitorDetailModel = updateVisitorDetailModelFromJson(jsonString);

import 'dart:convert';

UpdateVisitorDetailModel updateVisitorDetailModelFromJson(String str) =>
    UpdateVisitorDetailModel.fromJson(json.decode(str));

String updateVisitorDetailModelToJson(UpdateVisitorDetailModel data) =>
    json.encode(data.toJson());

class UpdateVisitorDetailModel {
  bool? success;
  Data? data;
  String? message;

  UpdateVisitorDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory UpdateVisitorDetailModel.fromJson(Map<String, dynamic> json) =>
      UpdateVisitorDetailModel(
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
  String? checkoutdate;
  String? checkouttime;
  int? status;
  String? statusdescription;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        checkoutdate: json["checkoutdate"],
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
        "checkoutdate": checkoutdate,
        "checkouttime": checkouttime,
        "status": status,
        "statusdescription": statusdescription,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
