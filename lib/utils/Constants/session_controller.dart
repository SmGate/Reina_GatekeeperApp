// ignore_for_file: non_constant_identifier_names

class SessionController {
  static final SessionController _SessionController =
      SessionController._internal();

  factory SessionController() {
    return _SessionController;
  }

  SessionController._internal();
  String bearerToken = "";
  String supportEmail = "";
  String supportPhone = "";
}
