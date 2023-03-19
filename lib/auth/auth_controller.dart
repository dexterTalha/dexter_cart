import 'package:dexter_cart/utils/my_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool isCodeSending = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _auth.currentUser;

  late String verificationId;
  int? resendToken;

  Future<void> phoneAuth({required BuildContext context, required String mobileNumber, int? token}) async {
    isCodeSending(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      timeout:const Duration(seconds: 10),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        if (context.mounted) {
          context.goNamed(home);
        }
        isCodeSending(false);
      },
      verificationFailed: (FirebaseAuthException e) {
        isCodeSending(false);
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
        this.resendToken = resendToken;
        context.goNamed(otpScreen, params: {'mobile': mobileNumber});
        isCodeSending(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        isCodeSending(false);
      },
      forceResendingToken: token,
    );
  }

  Future<String?> verifyOtp({required BuildContext context, required String smsCode}) async {
    try {
      PhoneAuthCredential authCredential =
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(authCredential);
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> resendOTP(BuildContext context, String mobile) async {
    await phoneAuth(context: context, mobileNumber: mobile, token: resendToken);
  }
}
