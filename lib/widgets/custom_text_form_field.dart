import 'package:flutter/material.dart';

import 'package:app/theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {

  final String? labelText; 
  final String? hintText; 
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final bool obscureText;
  final String? Function(String?) validator;
  final String? Function(String?) onChanged; 
  final int? maxLines;

  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.obscureText = false,
    this.maxLines,
    required this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(

      keyboardType: keyboardType,

      maxLines: obscureText==true ? 1 : maxLines,

      controller: TextEditingController(),
      cursorColor: Apptheme.primarydark,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration : InputDecoration(

        hintText  : hintText,
        prefixIcon: Icon(prefixIcon,color: const Color(0xff666666),),
        fillColor : const Color(0xFFededed),
        filled    : true,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide  : const BorderSide(color: Color(0xffededed))
        ),
        focusedBorder : OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide  : const BorderSide(color: Color(0xffededed))
        )

      ),
      
    );

  }

}