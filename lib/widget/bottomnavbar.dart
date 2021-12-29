import 'package:flutter/material.dart';
import 'package:movies/widget/texttheme.dart';
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({ Key? key,required this.icon,required this.title,this.enable}) : super(key: key);
  final IconData icon;
  final String title;
  final bool? enable;

  @override
  Widget build(BuildContext context) {
    bool ena = enable?? false;
    return InkWell(
      child: Center(
        child: Column(
          children: [
            Icon(
              icon,
              color: ena? Colors.white:Colors.white24,
            ),
            SpaceGap(2, AxisType.vertical),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.0,
                color: ena? Colors.white:Colors.white24,
              ),
            )
          ],
        ),
      ),
    );
  }
}