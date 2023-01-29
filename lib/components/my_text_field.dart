import 'package:flutter/material.dart';

import '../utils/my_theme.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final InputBorder? inputBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final String? label;
  final String? hint;
  final TextStyle? hintTextStyle;
  final TextStyle? lableTextStyle;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final TextInputType? inputType;
  final TextStyle? style;
  final bool isReadOnly;

  const MyTextField({
    super.key,
    this.controller,
    this.onTap,
    this.borderRadius,
    this.inputBorder,
    this.contentPadding,
    this.padding,
    this.label,
    this.hint,
    this.hintTextStyle,
    this.lableTextStyle,
    this.suffixWidget,
    this.prefixWidget,
    this.inputType = TextInputType.text,
    this.style,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: padding ?? const EdgeInsets.only(top: 10, bottom: 4),
        decoration: BoxDecoration(
          color: MyTheme.primaryContainerLight.withOpacity(0.6),
          borderRadius: borderRadius ??
              const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
        ),
        child: TextFormField(
          controller: controller,
          cursorColor: MyTheme.primary,
          onTap: onTap,
          readOnly: isReadOnly,
          style: style ??
              const TextStyle(
                  color: MyTheme.primary, fontSize: 18, fontFamily: "Roboto"),
          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            prefix: prefixWidget,
            suffix: suffixWidget,
            labelStyle: lableTextStyle ??
                TextStyle(
                  color: MyTheme.primary.withOpacity(0.8),
                ),
            contentPadding: contentPadding ?? const EdgeInsets.only(left: 20),
            border: inputBorder ?? InputBorder.none,
          ),
        ),
      ),
    );
  }
}
