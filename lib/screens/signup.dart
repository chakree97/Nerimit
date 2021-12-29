import 'package:flutter/material.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState(){
    super.initState();

  }
  @override
  void dispose(){
    userController.dispose();
    passController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWhite("Sign Up", 16),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: userController,
                  validator: (val)=> val!.isEmpty || !val.contains('@') ? "Enter a valid email": null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Email address'
                  ),
                ),
                SpaceGap(16, AxisType.vertical),
                TextFormField(
                  controller: passController,
                  validator: (val)=> (val!.length >= 8) ? null: "Password must over 8 characters",
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock_sharp),
                    labelText: 'Password'
                  ),
                ),
                SpaceGap(16, AxisType.vertical),
                TextFormField(
                  controller: phoneController,
                  validator: (val)=> val!.isEmpty  ? "Enter a phone number": null,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Phone number'
                  ),
                ),
                SpaceGap(32, AxisType.vertical),
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
                      child: TextWhite("Sign up >", 14),
                    ),
                  ),
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                       String message = await SignUp(userController.text, passController.text, phoneController.text);
                       messagesignup(context,message);
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}