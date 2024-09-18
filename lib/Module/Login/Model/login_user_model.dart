// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) =>
    LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  bool? success;
  String? message;
  Data? data;
  String? bearer;

  LoginUserModel({
    this.success,
    this.message,
    this.data,
    this.bearer,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        bearer: json["Bearer"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
        "Bearer": bearer,
      };
}

class Data {
  int? id;
  String? firstname;
  String? lastname;
  dynamic name;
  dynamic email;
  String? cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  dynamic code;
  int? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? gatekeeperid;
  int? subadminid;
  int? societyid;
  String? gateno;

  Data({
    this.id,
    this.firstname,
    this.lastname,
    this.name,
    this.email,
    this.cnic,
    this.address,
    this.mobileno,
    this.roleid,
    this.rolename,
    this.image,
    this.fcmtoken,
    this.code,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.gatekeeperid,
    this.subadminid,
    this.societyid,
    this.gateno,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        name: json["name"],
        email: json["email"],
        cnic: json["cnic"],
        address: json["address"],
        mobileno: json["mobileno"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        image: json["image"],
        fcmtoken: json["fcmtoken"],
        code: json["code"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        gatekeeperid: json["gatekeeperid"],
        subadminid: json["subadminid"],
        societyid: json["societyid"],
        gateno: json["gateno"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "name": name,
        "email": email,
        "cnic": cnic,
        "address": address,
        "mobileno": mobileno,
        "roleid": roleid,
        "rolename": rolename,
        "image": image,
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "gatekeeperid": gatekeeperid,
        "subadminid": subadminid,
        "societyid": societyid,
        "gateno": gateno,
      };
}
