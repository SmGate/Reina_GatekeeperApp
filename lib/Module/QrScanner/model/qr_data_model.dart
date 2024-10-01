class QrData {
  final String? type;

  final int? userId;
  final int? residentId;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? roleName;
  final String? mobile;
  final String? image;

  // Pre-approved Entry QR Data
  final int? id;
  final String? cnic;
  final String? vehicleNo;
  final String? visitorType;
  final String? description;
  final String? name;

  // Named constructor for resident data
  QrData.resident({
    this.type = 'resident',
    this.userId,
    this.residentId,
    this.firstName,
    this.lastName,
    this.address,
    this.roleName,
    this.mobile,
    this.image,
  })  : id = null,
        cnic = null,
        vehicleNo = null,
        visitorType = null,
        description = null,
        name = null;

  // Named constructor for pre-approved entry data
  QrData.preApproved({
    this.type = 'pre-approved',
    this.id,
    this.cnic,
    this.vehicleNo,
    this.visitorType,
    this.description,
    this.mobile,
    this.image,
    this.name,
  })  : userId = null,
        residentId = null,
        firstName = null,
        lastName = null,
        address = null,
        roleName = null;
}
