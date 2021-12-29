import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/provider/paymentmethod.dart';
import 'package:movies/provider/providersummary.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/screens/home.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:omise_flutter/omise_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class PaymentMethodList extends StatefulWidget {
  const PaymentMethodList({ Key? key }) : super(key: key);

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();
    final cardNumber = TextEditingController();
    final cardHolder = TextEditingController();
    final expiredmonth = TextEditingController();
    final expiredyear = TextEditingController();
    final cvv = TextEditingController();
    final int total = checkPrice();
    OmiseFlutter omise = OmiseFlutter(dotenv.env['OMISE_TOKEN']!);
     return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: const Color(0xff00ccff),
                      checkColor: Colors.white,
                      value: (context.watch<PaymentMethod>().methodType == PaymentMethodType.CreditCard)?true:false, 
                      onChanged: (value){
                        context.read<PaymentMethod>().ToggleMethod(PaymentMethodType.CreditCard);
                      }
                    ),
                    TextWhite("Credit Card", 16)
                  ],
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white
                    ),
                  ),
                  child: TextFormField(
                    inputFormatters: [
                      MaskedTextInputFormatter(
                        mask: "xxxx-xxxx-xxxx-xxxx", 
                        separator: "-"
                      )
                    ],
                    controller: cardNumber,
                    validator: (val) => (val!.length == 19)?null:"Invalid Card Nunber",
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabled: (context.watch<PaymentMethod>().methodType == PaymentMethodType.CreditCard)?true:false,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Card Number',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      floatingLabelStyle: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onChanged: (value){
                    
                    },
                  )
                ),
                SpaceGap(8, AxisType.vertical),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white
                    ),
                  ),
                  child: TextFormField(
                    controller: cardHolder,
                    validator: (val) => (val!.isNotEmpty)?null:"Enter your card holder name",
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabled: (context.watch<PaymentMethod>().methodType == PaymentMethodType.CreditCard)?true:false,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      labelText: 'Cardholder Name',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      floatingLabelStyle: const TextStyle(
                        color: Colors.white
                      )
                    ),
                    onChanged: (value){
                    
                    },
                  )
                ),
                SpaceGap(8, AxisType.vertical),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width*0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white
                        ),
                      ),
                      child: TextFormField(
                        validator: (val) => (val!.isNotEmpty) || (val.length > 2)?null:"Invalid Expired month",
                        controller: expiredmonth,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabled: (context.watch<PaymentMethod>().methodType == PaymentMethodType.CreditCard)?true:false,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: 'Expiry Month',
                          labelStyle: const TextStyle(
                            fontSize: 14
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelStyle: const TextStyle(
                            color: Colors.white
                          )
                        ),
                        onChanged: (value){
                        
                        },
                      )
                    ),
                    Container(
                      width: width*0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white
                        ),
                      ),
                      child: TextFormField(
                        controller: expiredyear,
                        validator: (val) => (val!.isNotEmpty) || (val.length > 2)?null:"Invalid Expired Year",
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabled: (context.watch<PaymentMethod>().methodType == PaymentMethodType.CreditCard)?true:false,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 0),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: 'Expiry Year',
                          labelStyle: const TextStyle(
                            fontSize: 14
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelStyle: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        onChanged: (value){
                        
                        },
                      )
                    ),
                    Container(
                      width: width*0.3,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white
                        ),
                      ),
                      child: TextFormField(
                        validator: (val) => (val!.isNotEmpty) && (val.length == 3)?null:"Invalid CVV",
                        controller: cvv,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabled: (context.watch<PaymentMethod>().methodType == PaymentMethodType.CreditCard)?true:false,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 0),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelText: 'CVV/CVV2',
                          labelStyle: const TextStyle(
                            fontSize: 14
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          floatingLabelStyle: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        onChanged: (value){
                        
                        },
                      )
                    ),
                  ],
                )
              ],
            ),
          )
        ),
        SpaceGap(8, AxisType.vertical),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: const Color(0xff00ccff),
                    checkColor: Colors.white,
                    value: (context.watch<PaymentMethod>().methodType == PaymentMethodType.Promptpay)?true:false,  
                    onChanged: (value){
                      context.read<PaymentMethod>().ToggleMethod(PaymentMethodType.Promptpay);
                    }
                  ),
                  TextWhite("QR code promptpay", 16)
                ],
              ),
              (context.read<PaymentMethod>().methodType == PaymentMethodType.Promptpay)?
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://promptpay.io/${dotenv.env['PROMPTPAY_PHONE']}/${total}")
                    )
                  )
                ):
                Container()
            ],
          ),
        ),
        SpaceGap(8, AxisType.vertical),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Checkbox(
                activeColor: const Color(0xff00ccff),
                checkColor: Colors.white,
                value: (context.watch<PaymentMethod>().methodType == PaymentMethodType.Banking)?true:false, 
                onChanged: (value){
                  context.read<PaymentMethod>().ToggleMethod(PaymentMethodType.Banking);
                }
              ),
              TextWhite("Bank Transfer", 16)
            ],
          ),
        ),
        SpaceGap(8, AxisType.vertical),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 0.0
            ),
            child: Container(
              width: width,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xff33FFFF),
                    Color(0xff00ccff),
                  ]
                )
              ),
              child: Center(
                child: TextWhite("Confirm Payment >", 16)
              ),
            ),
          ),
          onTap: ()async{
            if(context.read<PaymentMethod>().methodType == PaymentMethodType.CreditCard){
              if(_formKey.currentState!.validate()){
                loadingcircular(context);
                final token = await omise.token.create(
                  cardHolder.text, 
                  cardNumber.text, 
                  expiredmonth.text, 
                  expiredyear.text, 
                  cvv.text
                ).then(
                  (value)async{
                    final token = value.id.toString();
                    String secreKey = dotenv.env["OMISE_SECURITY_KEY"]!;
                    String basicAuth = "Basic "+base64Encode(utf8.encode(secreKey + ":"));
                    Uri url = Uri.parse("https://api.omise.co/charges");
                    var res = await http.post(
                      url,
                      headers: <String, String>{
                        'authorization': basicAuth,
                        'Cache-Control': 'no-cache',
                        'Content-Type': 'application/x-www-form-urlencoded',
                      },
                      body: <String,String>{
                        'amount': '${total}00',
                        'currency': 'thb',
                        'card': token
                      }
                    );
                    var resultCharge = jsonDecode(res.body);
                    if(res.statusCode == 200){
                      bool pass = await AddCollection();
                      if(pass){
                        Navigator.pop(context);
                        messagepayment(context,"Successful");
                      }
                      else{
                        print("Error Status Payment");
                        Navigator.pop(context);
                        messagepayment(context,"Failed to payment");
                      }
                    }
                    else{
                      print(resultCharge);
                      Navigator.pop(context);
                      messagepayment(context,"Failed to payment");
                    }
                  }
                ).catchError((error){
                  String title = error.code;
                  String message = error.message;
                  messagepageroute(context,message,"Successful",Home());
                });
              }
            }
            else if(context.read<PaymentMethod>().methodType == PaymentMethodType.Promptpay){
              print(PaymentMethodType.Promptpay);
              NavigatorAddSlipPage(context);
            }
            else if(context.read<PaymentMethod>().methodType == PaymentMethodType.Banking){
              print(PaymentMethodType.Banking);
            }
            else{
              print(PaymentMethodType.None);
            }
          },
        ),
      ],
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String? mask;
  final String? separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) { assert(mask != null); assert (separator != null); }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask!.length) return oldValue;
        if(newValue.text.length < mask!.length && mask![newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}