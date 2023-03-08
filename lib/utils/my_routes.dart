import 'package:dexter_cart/auth/auth_controller.dart';
import 'package:dexter_cart/screens/home_screen.dart';
import 'package:dexter_cart/screens/sign_up_screen.dart';
import 'package:flutter/foundation.dart';

import 'screen_imports.dart';
import 'package:go_router/go_router.dart';

const String home = "/";
const String splash = "/splash";
const String login = "/auth";
const String otpScreen = "otp_verification";
const String signUp = "signUp";
final router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: kIsWeb ? home : splash,
  routes: [
    GoRoute(
      path: home,
      name: home,
      builder: (context, state) => HomeScreen(),
      redirect: (context, state) {
        if (AuthController.instance.user == null) {
          return login;
        }
        return null;
      },
    ),
    GoRoute(
      path: splash,
      name: splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: "/auth",
      name: login,
      builder: (context, state) => LoginScreen(),
      routes: [
        GoRoute(
          path: 'otp_verification/:mobile',
          name: otpScreen,
          builder: (context, state) {
            String mobile = state.params['mobile'] ?? "";
            return OtpScreen(mobile: mobile);
          },
        ),
        GoRoute(
          path: signUp,
          name: signUp,
          builder: (context, state) => SignUpScreen(),
        ),
      ],
    ),
  ],
);
