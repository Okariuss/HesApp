class Me {
  static String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjIyMmM5ZGI0LTBiYmEtNDkxNy04ZWM4LWY4MDUxNWE5NzQyMiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6ImFkbWluQHJvb3QuY29tIiwiZnVsbE5hbWUiOiJyb290IEFkbWluIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InJvb3QiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9zdXJuYW1lIjoiQWRtaW4iLCJpcEFkZHJlc3MiOiIxMjcuMC4wLjEiLCJ0ZW5hbnQiOiJyb290IiwiaW1hZ2VfdXJsIjoiIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbW9iaWxlcGhvbmUiOiIiLCJleHAiOjE2OTgzODQ5MzB9.x_jn0Dh0BN9LpbMVlRwwSBvBSWsRTc3XB5OeIgVwWOc";
  static String _mail = "johndoe@.com";
  static String _username = "";
  static String _password = "";

  static String get token => _token;
  static String get mail => _mail;
  static String get username => _username;
  static String get password => _password;

  static set setToken(String newToken) {
    _token = newToken;
  }

  static set setMail(String newMail) {
    _mail = newMail;
  }

  static set setName(String newName) {
    _username = newName;
  }

  static set setPassword(String newPassword) {
    _password = newPassword;
  }
}
