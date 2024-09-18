// To parse this JSON data, do
//
//     final residentialEmergencyModel = residentialEmergencyModelFromJson(jsonString);

import 'dart:convert';

ResidentialEmergencyModel residentialEmergencyModelFromJson(String str) =>
    ResidentialEmergencyModel.fromJson(json.decode(str));

String residentialEmergencyModelToJson(ResidentialEmergencyModel data) =>
    json.encode(data.toJson());

class ResidentialEmergencyModel {
  List<Datum>? data;

  ResidentialEmergencyModel({
    this.data,
  });

  factory ResidentialEmergencyModel.fromJson(Map<String, dynamic> json) =>
      ResidentialEmergencyModel(
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
  int? residentid;
  int? societyid;
  int? subadminid;
  String? problem;
  String? description;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Resident>? resident;

  Datum({
    this.id,
    this.residentid,
    this.societyid,
    this.subadminid,
    this.problem,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.resident,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        residentid: json["residentid"],
        societyid: json["societyid"],
        subadminid: json["subadminid"],
        problem: json["problem"],
        description: json["description"]!,
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        resident: json["resident"] == null
            ? []
            : List<Resident>.from(
                json["resident"]!.map((x) => Resident.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "residentid": residentid,
        "societyid": societyid,
        "subadminid": subadminid,
        "problem": problem,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "resident": resident == null
            ? []
            : List<dynamic>.from(resident!.map((x) => x.toJson())),
      };
}

class Resident {
  int? id;
  String? firstname;
  String? lastname;
  dynamic name;
  dynamic email;
  dynamic cnic;
  String? address;
  String? mobileno;
  int? roleid;
  String? rolename;
  String? image;
  String? fcmtoken;
  int? code;
  int? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;

  Resident({
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
  });

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"]!,
        name: json["name"],
        email: json["email"],
        cnic: json["cnic"],
        address: json["address"]!,
        mobileno: json["mobileno"],
        roleid: json["roleid"],
        rolename: json["rolename"]!,
        image: json["image"]!,
        fcmtoken: json["fcmtoken"],
        code: json["code"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstnameValues.reverse[firstname],
        "lastname": lastnameValues.reverse[lastname],
        "name": name,
        "email": email,
        "cnic": cnic,
        "address": address,
        "mobileno": mobileno,
        "roleid": roleid,
        "rolename": rolename,
        "image": imageValues.reverse[image],
        "fcmtoken": fcmtoken,
        "code": code,
        "is_verified": isVerified,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum Firstname { ATTIZAZ, JAHANZEB, JAVED }

final firstnameValues = EnumValues({
  "Attizaz": Firstname.ATTIZAZ,
  "jahanzeb": Firstname.JAHANZEB,
  "javed": Firstname.JAVED
});

enum Image { IMAGES_USER_PNG, THE_1716874747_JPG, THE_1719657817_JPG }

final imageValues = EnumValues({
  "images/user.png": Image.IMAGES_USER_PNG,
  "1716874747.jpg": Image.THE_1716874747_JPG,
  "1719657817.jpg": Image.THE_1719657817_JPG
});

enum Lastname { BASHEER, HUSSAIN, MUGHAL }

final lastnameValues = EnumValues({
  "basheer": Lastname.BASHEER,
  "hussain": Lastname.HUSSAIN,
  "Mughal": Lastname.MUGHAL
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
