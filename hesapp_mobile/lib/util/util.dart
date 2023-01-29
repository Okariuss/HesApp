class Me {
  static List<String> _myRoles = ["SuperAdmin"];
  static String _token =
      "";
  static String _mail = "johndoe@.com";
  static String _name = "";

  static List<String> get myRoles => _myRoles;
  static String get token => _token;
  static String get mail => _mail;
  static String get name => _name;

  static set setMyRoles(List<String> newRoles) {
    _myRoles = newRoles;
  }

  static set setToken(String newToken) {
    _token = newToken;
  }

  static set setMail(String newMail) {
    _mail = newMail;
  }

  static set setName(String newName) {
    _name = newName;
  }
}
