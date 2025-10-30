import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedDb {
  static late final SharedPreferences prefs;
  static final String email = 'email';
  static final String password = 'password';

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static updateLoginDataAtSharedDb(String email, String password) {
    prefs.setString(AuthSharedDb.email, email);
    prefs.setString(AuthSharedDb.password, password);
  }

  static removeloginDataFromSharedDb() {
    prefs.remove(AuthSharedDb.email);
    prefs.remove(AuthSharedDb.password);
  }

  static bool checkloginDataFromSharedDb() {
    String? email = prefs.getString(AuthSharedDb.email);
    String? password = prefs.getString(AuthSharedDb.password);
    return (email != null && password != null);
  }

  static Map<String, String?> fetchLoginDataFromSharedDb() {
    String? email = prefs.getString(AuthSharedDb.email);
    String? password = prefs.getString(AuthSharedDb.password);
    return {'email': email, 'password': password};
  }
}
