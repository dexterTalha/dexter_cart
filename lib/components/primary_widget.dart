import 'package:flutter/material.dart';

class PrimaryWidget extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final AppBar? appBar;
  final Widget? drawer;

  const PrimaryWidget({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.appBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      backgroundColor: backgroundColor,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: padding ?? const EdgeInsets.all(20),
        margin: margin,
        child: child,
      ),
    );
  }
}
