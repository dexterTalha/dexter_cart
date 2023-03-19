import 'package:dexter_cart/auth/auth_controller.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // //334a499c-6be3-4f5c-8bc4-6b78cd53e92f
  // await FirebaseAppCheck.instance.activate(
  //   // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  //   // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
  //   // your preferred provider. Choose from:
  //   // 1. debug provider
  //   // 2. safety net provider
  //   // 3. play integrity provider
  //   androidProvider: AndroidProvider.debug,
  // );
  setPathUrlStrategy();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: ExcludeSemantics(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}
