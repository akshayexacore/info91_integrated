class AppValidator{

  static bool validateMobile(String mobile) {
    String pattern = r'^(\+91)?(-)?\s*?(91)?\s*?(\d{3})-?\s*?(\d{3})-?\s*?(\d{4})';
    RegExp regExp = RegExp(pattern);
    if (mobile.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(mobile)) {
      return false;
    }
    return true;
  }
  static bool validateMail(String mail) {
    String pattern =
        r"^[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,})$";
    RegExp regExp = RegExp(pattern);
    if (mail.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(mail)) {
      return false;
    }
    return true;
  }

  static bool validateName(String name) {
    //String pattern = r'(^[A-z]*$|^[A-z]+\s[A-z]*$)';
    //String pattern = r"(^[A-z .]*$|^[A-z]+\s[A-z]*$)";
    //RegExp regExp = RegExp(pattern);
    if (name.isEmpty) {
      return false;
    } /*else if (!regExp.hasMatch(name)) {
      return false;
    }*/
    return true;
  }

  static bool validateReferral(String referralCode) {
    if (referralCode.isEmpty) {
      return false;
    }
    if (referralCode.contains(' ')) {
      return false;
    }
    if (referralCode.length < 4) {
      return false;
    }
    return true;
  }

  static bool isNull(String? str) {
    return str == null || str.isEmpty;
  }
  static bool isValidName(String str) {
    RegExp rex = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    return rex.hasMatch(str);
  }
 static bool isValidUrl(String text) {
  final RegExp urlRegExp = RegExp(
    r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$', // URL matching pattern
    caseSensitive: false,
    multiLine: false,
  );
  return urlRegExp.hasMatch(text);
}
  bool isValidYouTubeLink(String url) {
    final RegExp youtubeRegex = RegExp(
      r'^(https?:\/\/)?(www\.)?(youtube\.com|youtu\.be)\/.+$',
      caseSensitive: false,
    );
    return youtubeRegex.hasMatch(url);
  }
}