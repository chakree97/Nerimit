import 'package:movies/log/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account {
  String? username;
  String? password;
  bool? islogin;
}

  Future<String> GetUsername() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username') ?? "Sign in";
    return username;
  }

  Future<String> GetPassword() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String password = preferences.getString('password') ?? "";
    return password;
  }

  Future<bool> CheckLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool islogin = preferences.getBool('islogin') ?? false;
    return islogin;
  }
