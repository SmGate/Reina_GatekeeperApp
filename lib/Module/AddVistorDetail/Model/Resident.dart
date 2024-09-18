
class Resident {
  late final int id;
  late final int residentid;

  late final String houseaddress;

  Resident({
    required this.id,
    required this.residentid,
    required this.houseaddress,
    
  });

  factory Resident.fromJson(Map<dynamic, dynamic> json) {
    return Resident(
      id: json['id'],
      residentid: json['residentid'],
      houseaddress: json['houseaddress'],
    );
  }
}
