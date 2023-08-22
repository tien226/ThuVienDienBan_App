class Constants {
  static const REGEX_PHONE_NUMBER = r"^(?:[+0]9)?[0-9]{10}$";
  static const REGEX_EMAIL =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const REGEX_PASSWORD =
      r"^(?=.*[A-Z])(?=.*\d)(?=.*[$&+,:;=?@#|'<>.-^*()%!])[A-Za-z\d$&+,:;=?@#|'<>.-^*()%!]{8,}$";
  static const String REQUESTED  = "REQUESTED";
  static const String APPROVED = "APPROVED";
  static const String BORROWED  = "BORROWED";
  static const String RETURNED = "RETURNED";
  static const String OVER_DUE = "OVER_DUE";
  static const String CANCELED = "CANCELED";
}
