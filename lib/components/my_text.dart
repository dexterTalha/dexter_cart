import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  const MyText(this.text, {Key? key, this.textStyle, this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      key: key,
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
