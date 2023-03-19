import 'dart:async';

import 'package:dexter_cart/auth/auth_controller.dart';
import 'package:dexter_cart/utils/image_url.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:dexter_cart/utils/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' as riv;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      AuthController controller = AuthController.instance;
      if (controller.user != null) {
        if (await controller.checkUserExists()) {
          if (context.mounted) {
            context.goNamed(home);
          }
        } else {
          if (context.mounted) context.goNamed(login);
        }
      } else {
        context.goNamed(login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyTheme.primaryLight,
              MyTheme.primaryLight.withOpacity(0.8),
              MyTheme.primary,
              MyTheme.primary,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Image.asset(
                    ImageUrl.logo,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 150,
              width: double.maxFinite,
              child: riv.RiveAnimation.asset(
                RiveUrl.loader,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
