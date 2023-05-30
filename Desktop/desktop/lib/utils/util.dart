class Me {
  static String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY4NTM4ODI3NywianRpIjoiYjY4ZTRiM2YtM2IwOC00NWFlLWIyZmQtM2U1NjdjYjA3ZGRhIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6NCwibmJmIjoxNjg1Mzg4Mjc3LCJleHAiOjE2ODUzODkxNzd9.1ekIzpTmbp2jSqOIeRD3ygaEG6eYIEhnxCWqfni3lTU";
  static String _firstName = "";
  static String _lastName = "";
  static String _mail = "";
  static String _password = "";
  static String _phone = "";
  static String _restaurantName = "";
  static String _restaurantDescription = "";
  static String _restaurantAddress = "";
  static String _restaurantPhone = "";
  static String _restaurantLogo = "";

  static String get token => _token;
  static String get firstName => _firstName;
  static String get lastName => _lastName;
  static String get mail => _mail;
  static String get password => _password;
  static String get phone => _phone;
  static String get restaurantName => _restaurantName;
  static String get restaurantDescription => _restaurantDescription;
  static String get restaurantAddress => _restaurantAddress;
  static String get restaurantPhone => _restaurantPhone;
  static String get restaurantLogo => _restaurantLogo;

  static set setToken(String newToken) {
    _token = newToken;
  }

  static set setFirstName(String newFirstName) {
    _firstName = newFirstName;
  }

  static set setLastName(String newLastName) {
    _lastName = newLastName;
  }

  static set setMail(String newMail) {
    _mail = newMail;
  }

  static set setPassword(String newPassword) {
    _password = newPassword;
  }

  static set setPhone(String newPhone) {
    _phone = newPhone;
  }

  static set setRestaurantName(String newRestaurantName) {
    _restaurantName = newRestaurantName;
  }

  static set setReestaurantDescription(String newRestaurantDescription) {
    _restaurantDescription = newRestaurantDescription;
  }

  static set setRestaurantAddress(String newRestaurantAddress) {
    _restaurantAddress = newRestaurantAddress;
  }

  static set setRestaurantPhone(String newRestaurantPhone) {
    _restaurantPhone = newRestaurantPhone;
  }

  static set setRestaurantLogo(String newRestaurantLogo) {
    _restaurantLogo = newRestaurantLogo;
  }
}
