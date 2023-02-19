import 'package:dexter_cart/screens/login_screen.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      key: Get.key,
      routerDelegate: MyRoutes().router.routerDelegate,
      routeInformationParser: MyRoutes().router.routeInformationParser,
      routeInformationProvider: MyRoutes().router.routeInformationProvider,
    );
  }
}
