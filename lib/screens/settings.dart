import 'package:flutter/material.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/model/account.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Account account = Account();
  String? username;
  String? password;
  bool? islogin;

  getUsername() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString('username') ?? "Sign in";
      print(username);
    });
  }

  getPassword() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      password = preferences.getString('password') ?? "";
      print(password);
    });
  }

  checkLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      islogin = preferences.getBool('islogin') ?? false;
      print(islogin);
    });
  }

  @override
  void initState(){
    super.initState();
    // ClearAccount();
    getUsername();
    getPassword();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWhite('Setting', 18),
        actions: (islogin == null)?[]:(!islogin!)?
        []:
        [
          IconButton(
            onPressed: () async {
              String message = await SignOut(username!);
              messagedialog(context, message, username!, password!);
            },
            icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.person),
              color: const Color(0xff00ccff),
              onPressed: (){
              },
            ),
            title: InkWell(
              child: Textblue(username??"Sign in", 14),
              onTap: (){
                if(!islogin!){
                  NavigatorLoginPage(context);
                }
              },
            ),
            subtitle: InkWell(
              child: TextWhite('Edit Profile >', 10),
              onTap: (){
                // ShowModalLogin(context);
              },
            ),
          ),
          ListTile(
            title: TextWhite('My Collection', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
                if(!islogin!){
                  NavigatorLoginPage(context);
                }
                else{
                  NavigatorCollectionPage(context);
                }
              },
            ),
          ),
          ListTile(
            title: TextWhite('My Favorite', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
                if(!islogin!){
                  NavigatorLoginPage(context);
                }
                else{
                  NavigatorFavoritePage(context);
                }
              },
            ),
          ),
          ListTile(
            title: TextWhite('Recently Watched', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
                NavigatorRecentlyPage(context);
              },
            ),
          ),
          ListTile(
            title: TextWhite('Order Summary', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
                NavigatorOrderSummaryPage(context);
              },
            ),
          ),
          ListTile(
            title: TextWhite('Order History', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
                NavigatorOrderHistory(context);
              },
            ),
          ),
          ListTile(
            title: TextWhite('Terms Of Use', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
              },
            ),
          ),
          ListTile(
            title: TextWhite('Privacy Policy', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
              },
            ),
          ),
          ListTile(
            title: TextWhite('Contact us', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
              },
            ),
          ),
          ListTile(
            title: TextWhite('Language', 14),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              iconSize: 16,
              color: Colors.white,
              onPressed: (){
              },
            ),
          )
        ],
      ),
    );
  }
}