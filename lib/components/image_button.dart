import 'package:flutter/material.dart';

import '../utils/my_theme.dart';

class MyImageButton extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final Function()? onTap;
  const MyImageButton(this.image, {super.key, this.height = 60, this.width = 60, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: MyTheme.primaryContainerLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(image),
        ),
      ),
    );
  }
}
