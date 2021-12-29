import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/screens/home.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isChecked = false;
String? user;
String? pass;
String? confirmpass;


void ShowModalRegister(BuildContext context){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        titlePadding: EdgeInsets.only(left: 20.0 ,top: 20.0,bottom: 0),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
        title: Row(
          children: [
            TextWhite('Register', 18),
            Expanded(child: SpaceGap(0.001, AxisType.horizontal)),
            IconButton(
              icon: const Icon(Icons.close_outlined),
              iconSize: 14,
              color: const Color(0xff00ccff),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: 210,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Username'
                )
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_sharp),
                  labelText: 'Password'
                )
              ),
              SpaceGap(24, AxisType.vertical),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff35D6ED),
                        Color(0xff00ccff),
                      ]
                    )
                  ),
                  child: Center(
                    child: TextWhite("Register >", 14),
                  ),
                ),
                onTap: (){

                },
              ),
            ],
          ),
        )
      );
    }
  );
}

void ShowModalForgotPassword(BuildContext context){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        titlePadding: EdgeInsets.only(left: 20.0 ,top: 20.0,bottom: 0),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
        title: Row(
          children: [
            TextWhite('Reset Password', 18),
            Expanded(child: SpaceGap(0.001, AxisType.horizontal)),
            IconButton(
              icon: const Icon(Icons.close_outlined),
              iconSize: 14,
              color: const Color(0xff00ccff),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: 280,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Username'
                )
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_sharp),
                  labelText: 'Password'
                )
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock_sharp),
                  labelText: 'Confirm Password'
                )
              ),
              SpaceGap(24, AxisType.vertical),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff35D6ED),
                        Color(0xff00ccff),
                      ]
                    )
                  ),
                  child: Center(
                    child: TextWhite("Reset Password >", 14),
                  ),
                ),
                onTap: (){

                },
              ),
            ],
          ),
        )
      );
    }
  );
}

void messagedialog(BuildContext context,String message,String user,String pass){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        title: TextWhite(message, 16),
        actions: [
          InkWell(
            child: Textblue("OK", 12),
            onTap: (){
              if(message == "Successful"){
                Navigator.pop(context);
                saveaccount(user, pass, true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
              }
              else if(message =="Log Out Complete"){
                Navigator.pop(context);
                ClearAccount();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
              }
              else{
                Navigator.pop(context); 
              }
            },
          )
        ],
      );
    }
  );
}

void messagesignup(BuildContext context,String message){
    showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        title: TextWhite(message, 16),
        actions: [
          InkWell(
            child: Textblue("OK", 12),
            onTap: (){
              if(message == "Successful"){
                Navigator.pop(context);
                NavigatorLoginPage(context);
              }
              else{
                Navigator.pop(context); 
              }
            },
          )
        ],
      );
    }
  );
}

void loadingcircular(BuildContext context){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      );
    }
  );
}
 
void messagepageroute(BuildContext context,String message,String messageref,Widget page){
    showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        title: TextWhite(message, 16),
        actions: [
          InkWell(
            child: Textblue("OK", 12),
            onTap: (){
              if(message == messageref){
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
              }
              else{
                Navigator.pop(context); 
              }
            },
          )
        ],
      );
    }
  );
}

void messagepayment(BuildContext context,String message){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        title: TextWhite(message, 16),
        actions: [
          InkWell(
            child: Textblue("OK", 12),
            onTap: (){
              if(message == "Successful"){
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
              }
              else{
                Navigator.pop(context); 
              }
            },
          )
        ],
      );
    }
  );
}

void messagedeletehsitory(BuildContext context,int position){
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        actionsPadding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
        title: TextWhite("Are you delete?", 16),
        actions: [
          InkWell(
            child: Textblue("OK", 12),
            onTap: ()async{
              String message = await DeleteHistory(position);
              if(message == "ok"){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Home()));
              }
              else{
                Navigator.pop(context); 
              }
            },
          ),
          SpaceGap(10, AxisType.vertical),
          InkWell(
            child: Textblue("Cancel", 12),
            onTap: (){
              Navigator.pop(context); 
            },
          )
        ],
      );
    }
  );
}

Future<void> saveaccount(String user,String pass,bool islogin) async{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences preferences = await _prefs;
  preferences.setString('username', user);
  preferences.setString('password', pass);
  preferences.setBool('islogin', islogin);
}

Future<void> ClearAccount() async{
  print("clear");
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences preferences = await _prefs;
  preferences.clear();
  // preferences.setString('username', "Sign in");
  // preferences.setString('password', "");
  // preferences.setBool('islogin', false);
}