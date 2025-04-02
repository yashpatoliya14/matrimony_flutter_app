import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildButton({
  required label,
  required textColor,
  required backgroundColor,
  borderColor,
  icon,
}) {
  return Container(
    height: 50,
    padding: EdgeInsets.symmetric(horizontal: 70),
    margin: EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: backgroundColor ?? Colors.purple,
      borderRadius: BorderRadius.circular(50),

      border:borderColor!=null ?  Border.symmetric(vertical: BorderSide(color: borderColor,width: 0.5),horizontal: BorderSide(color: borderColor,width: 0.5)):null
    ),
    child: TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(splashFactory: NoSplash.splashFactory),
      label: Text(
        label,
        style: TextStyle(color: textColor,fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      icon: icon,
    ),
  );
}


