import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './form_utils.dart';



Widget getTextFormField({
  controller,
  label,
  errorMsg,
  icon,
  inputFormator,
  Function? validateFun,
  keyboardType,
  onTap,
  readOnly,
  hideText,
  suffixIcon,
  focusNode
}){
  return StatefulBuilder(
    builder: (context,setState){
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorMsg,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: Colors.purple)
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
        ),

        keyboardType: keyboardType!=null ? keyboardType : null,

        textCapitalization: TextCapitalization.words,

        inputFormatters:inputFormator!=null?inputFormator:[],

        validator: (value) {
          return validateFun!(value);
        },

        onChanged: (value) {
          setState(() {
            errorMsg = validateFun!(value);
          });
        },
        obscureText: hideText!=null ?hideText:false,

        readOnly: readOnly!=null?true:false,
        onTap: onTap,

      );
    },
  );
}

Widget getRadioButtonError(context) {
  if (genderError != null) {
    return Text(
      genderError!,
      style: TextStyle(color: Colors.redAccent),
    );
  }
  return SizedBox.shrink();
}

Widget getCityError(context) {
  if (cityError != null) {
    return Container(
        child: Text(
          cityError!,
          style: TextStyle(color: Colors.redAccent),
        ));
  }
  return SizedBox.shrink();
}

Widget getHobbiesError(context) {
  if (hobbiesError != null) {
    return Container(
      child: Text(
        hobbiesError!,
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
  return SizedBox.shrink();
}