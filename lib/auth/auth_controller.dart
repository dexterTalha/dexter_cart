import 'package:dexter_cart/utils/app_constants.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool isCodeSending = false.obs;
  RxBool isUserCreating = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  User? get user => _auth.currentUser;

  late String verificationId;
  int? resendToken;

  Future<void> phoneAuth({required BuildContext context, required String mobileNumber, int? token}) async {
    isCodeSending(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: mobileNumber,
      timeout: const Duration(seconds: 10),
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        User? user = userCredential.user;
        if (context.mounted && user != null) {
          context.goNamed(login);
        }
        String nextPage = signUp;
        if (await checkUserExists(user?.uid ?? "")) {
          nextPage = home;
        }
        if (context.mounted) {
          context.goNamed(nextPage);
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
      PhoneAuthCredential authCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
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

  Future<bool> checkUserExists([String? uid]) async {
    DocumentSnapshot snapshot = await _db.collection(AppConstants.userCollection).doc(uid ?? user?.uid).get();
    return snapshot.exists;
  }

  Future<bool> insertUser({String? mobile, String? name, String? email}) async {
    isUserCreating(true);
    try {
      await _db.collection(AppConstants.userCollection).doc(user?.uid).set({
        'name': name,
        'email': email,
        'mobile': mobile,
        'uid': user?.uid,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    isUserCreating(false);
    return false;
  }
}
