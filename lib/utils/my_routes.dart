import 'package:dexter_cart/screens/sign_up_screen.dart';

import 'screen_imports.dart';
import 'package:go_router/go_router.dart';

class MyRoutes {
  static const String splash = "/";
  static const String login = "login";
  static const String otpScreen = "otpscreen";
  static const String signUp = "signUp";
  final router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "splash",
        builder: (context, state) => SplashScreen(),
        routes: [
          GoRoute(
            path: "auth",
            name: login,
            builder: (context, state) => LoginScreen(),
            routes: [
              GoRoute(
                path: 'otp_verification',
                name: otpScreen,
                builder: (context, state) => OtpScreen(),
              ),
              GoRoute(
                path: signUp,
                name: signUp,
                builder: (context, state) => SignUpScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
