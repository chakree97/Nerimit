import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  @override
  void initState(){
    super.initState();

  }
  @override
  void dispose(){
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWhite("Login", 16),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0
            ),
            child: Column(
              children: [
                TextFormField(
                  validator: (val)=> val!.isEmpty || !val.contains('@') ? "Enter a valid email": null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Username'
                  ),
                  controller: userController,
                ),
                SpaceGap(16, AxisType.vertical),
                TextFormField(
                  validator: (val)=> (val!.length >= 8) ? null: "Password must over 8 characters",
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_sharp),
                    labelText: 'Password'
                  ),
                  controller: passController,
                ),
                SpaceGap(16, AxisType.vertical),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: SpaceGap(2, AxisType.horizontal)),
                    InkWell(
                      child: TextWhite("Forgot Password?", 12),
                      onTap: (){
                        // Navigator.pop(context);
                        // ShowModalForgotPassword(context);
                      },
                    )
                  ],
                ),
                SpaceGap(16, AxisType.vertical),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
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
                      child: TextWhite("Login >", 14),
                    ),
                  ),
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      String message =  await Login(userController.text, passController.text);
                      messagedialog(context, message,userController.text, passController.text);
                    }
                  },
                ),
                SpaceGap(16, AxisType.vertical),
                TextWhite("Or", 12),
                SpaceGap(16, AxisType.vertical),
                InkWell(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: const Color(0xff3B5998)
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.facebookF),
                          SpaceGap(15, AxisType.horizontal),
                          TextWhite("Continue With Facebook", 14),
                        ],
                      )
                    ),
                  ),
                  onTap: (){

                  },
                ),
                SpaceGap(16, AxisType.vertical),
                Row(
                  children: [
                    TextWhite("Don't have an account?", 12),
                    SpaceGap(8, AxisType.horizontal),
                    InkWell(
                      child: Textblue("Register", 12),
                      onTap: (){
                        NavigatorSignUpPage(context);
                        // Navigator.pop(context);
                        // ShowModalRegister(context);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}