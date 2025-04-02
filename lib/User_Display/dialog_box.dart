import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> getDialogBox(context,{action,label}){
  return showDialog(context: context, builder: (context){
    return CupertinoAlertDialog(
      title: Text(label,style: TextStyle(color: Colors.green),),
      actions:action,
    );
  });
}