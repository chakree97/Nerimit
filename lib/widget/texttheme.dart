import 'package:flutter/material.dart';

enum AxisType{
  horizontal,
  vertical
}

Widget TextWhite(String text,double size){
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: size,
      fontFamily: 'Poppins'
    ),
  );
}

Widget Textblue(String text,double size){
  return Text(
    text,
    style: TextStyle(
      color: const Color(0xff00ccff),
      fontSize: size,
      fontFamily: 'Poppins'
    ),
  );
}

Widget TextGrey(String text,double size){
  return Text(
    text,
    style: TextStyle(
      color: Colors.white60,
      fontSize: size,
      fontFamily: 'Poppins',
      decoration: TextDecoration.lineThrough
    ),
  );
}

Widget TextOrange(String text,double size){
  return Text(
    text,
    style: TextStyle(
      color: Colors.orangeAccent,
      fontSize: size,
      fontFamily: 'Poppins'
    ),
  );
}

Widget TextRed(String text,double size){
  return Text(
    text,
    style: TextStyle(
      color: Colors.red,
      fontSize: size,
      fontFamily: 'Poppins'
    ),
  );
}

Widget SpaceGap(double height,AxisType type){
  if(type == AxisType.horizontal){
    return SizedBox(
      width: height,
    );
  }
  else{
    return SizedBox(
      height: height,
    );
  }
}

Widget AddtoCart(double Sized){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        Icons.shopping_cart,
        color: Colors.white,
        size: Sized*3/2
      ),
      SpaceGap(4, AxisType.horizontal),
      TextWhite("Add to Cart", Sized)
    ],
  );
}
