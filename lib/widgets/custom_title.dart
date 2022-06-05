
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {

  final String text;
  final Color? color;
  final double? size;

  const CustomTitle({
    Key? key,
    this.color,
    this.size,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: color ?? Colors.black,
        fontSize: size ?? 20,
      ),
    );
  }
}
