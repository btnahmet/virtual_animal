class UserData {
  static String? email;
  static String? password;
  static String? name;

  static void saveUserData(String userEmail, String userPassword, String userName) {
    email = userEmail;
    password = userPassword;
    name = userName;
  }

  static bool validateUser(String userEmail, String userPassword) {
    return email == userEmail && password == userPassword;
  }
} 