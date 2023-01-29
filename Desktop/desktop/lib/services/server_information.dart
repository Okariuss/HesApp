class SI {
  static String convertMessage(String input) {
    var input2 = input.replaceAll('"Succeeded"', '"succeeded"');
    var input3 = input2.replaceAll('"Message"', '"message"');
    var input4 = input3.replaceAll('"Errors"', '"errors"');
    var input5 = input4.replaceAll('"Data"', '"data"');
    return input5;
  }
}
