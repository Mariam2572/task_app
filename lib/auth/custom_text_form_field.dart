// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:task_app/theme.dart';
//typedef myValidator = String? Function(String?);
class CustomTextFormField extends StatelessWidget {
String label;
TextEditingController controller;
TextInputType keyboardType;
bool obscureText;
String? Function(String?) validator;
  CustomTextFormField({
required this.validator,
required this.label,
required this.controller,
this.obscureText = false,
this.keyboardType = TextInputType.text,
  }) ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        obscureText:obscureText ,
        validator:validator ,
        keyboardType:keyboardType ,
        controller:controller ,
    decoration: InputDecoration(
      label: Text(label),
      labelStyle: TextStyle(
        color: MyTheme.greyColor,
        
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          width: 1,
          color: MyTheme.greyColor
        )

      ),focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
         borderSide: BorderSide(
          width: 1,
          color: MyTheme.redColor
        ) ,),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
         borderSide: BorderSide(
          width: 1,
          color: MyTheme.redColor
        ),

      )
      
    ) ,
      ),
    );
  }
}
