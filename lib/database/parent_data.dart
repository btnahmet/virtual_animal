class ParentData {
  static String? email;
  static String? password;
  static String? name;

  static void saveParentData(String parentEmail, String parentPassword, String parentName) {
    email = parentEmail;
    password = parentPassword;
    name = parentName;
  }

  static bool validateParent(String parentEmail, String parentPassword) {
    return email == parentEmail && password == parentPassword;
  }
} 