class TextUtil{

  static bool isEmpty(String? str){
    return str==null||str.isEmpty;
  }
}

class RegexChecker {
  static const String EMAIL_PATTERN = "^[\\w!#\$%&'*+/=?^_`\"`\"`{|}~-]+(?:\\.[\\w!#\$%&'*+/=?^_`\"`\"`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[a-zA-Z0-9](?:[\\w-]*[\\w])?\$";

  static bool isLetterAndDigit(String text) {
    return RegExp("^[a-zA-Z0-9]+\$").hasMatch(text);
  }

  static bool isEmail(String text) {
    return RegExp(EMAIL_PATTERN)
        .hasMatch(text);
  }

  static bool smsCodeInfoValid(String smsCode){
    return RegExp("^[0-9]{6}\$").hasMatch(smsCode);
  }

}

String formatTime(int timeInMillseconds) {
  var d = DateTime.fromMillisecondsSinceEpoch(timeInMillseconds * 1000);
  return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}";
}