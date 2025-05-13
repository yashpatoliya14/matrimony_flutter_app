import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildButton({
  required label,
  required textColor,
  required backgroundColor,
  borderColor,
  icon,
  onPressed
}) {
  return OutlinedButton.icon(
    onPressed: onPressed,
    label: Text(label,style: GoogleFonts.nunito(color: textColor),),
    icon: icon,
    
    style: OutlinedButton.styleFrom(
      backgroundColor: backgroundColor,
      
      side: BorderSide(color: borderColor ?? Colors.black12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      
      ),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 70)
    ),
  );
}
