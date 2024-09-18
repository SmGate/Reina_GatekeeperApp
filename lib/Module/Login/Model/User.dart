
class User {
  final int? userid;
  final String? firstName;
  final String? lastName;
  final String? cnic;
  final int? roleId;
  final int? subadminid;
  final int? societyid;
  
  final String? roleName;
  final String? bearerToken;
  // final List<GateKeeper>? gatekeeperlist;

  User({
    this.userid,
    this.subadminid,
    this.societyid,
    
    this.firstName,
    this.lastName,
    this.cnic,
    this.roleId,
    this.roleName,
    this.bearerToken,
    // this.gatekeeperlist,
  });
}
