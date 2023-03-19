import 'package:dexter_cart/auth/auth_controller.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../components/button_widget.dart';
import '../components/my_text.dart';
import '../utils/my_theme.dart';

class OtpScreen extends StatefulWidget {
  final String? mobile;
  const OtpScreen({this.mobile, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.white;
    var fillColor = MyTheme.primaryContainerLight.withOpacity(0.6);
    var borderColor = MyTheme.primaryContainerLight.withOpacity(0.6);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: MyTheme.primary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        color: MyTheme.primaryContainerLight.withOpacity(0.6),
      ),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Card(
                elevation: 4,
                child: GestureDetector(
                  onTap: () {
                    // TODO : Back button Implementation
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyTheme.primaryContainerLight.withOpacity(0.6),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: MyTheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 80),
            const MyText(
              "Fill the code",
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: MyTheme.primary,
                fontSize: 22,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            Directionality(
              // Specify direction if desired
              textDirection: TextDirection.ltr,
              child: Pinput(
                controller: pinController,
                length: 6,
                focusNode: focusNode,
                androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,

                defaultPinTheme: defaultPinTheme,
//                 validator: (value) async{
//                   if(value.isNotEmpty && value.length < 6){
//                     return await _authController.verifyOtp(context: context, smsCode: value!)
// }
// return 'Enter OTP';
//                 },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) async {
                  debugPrint('onCompleted: $pin');
                  if (pin.isNotEmpty && pin.length == 6) {
                    String? value = await _authController.verifyOtp(context: context, smsCode: pin);
                    if (value == null && context.mounted) {
                      String nextPage = signUp;
                      if (await _authController.checkUserExists(_authController.user?.uid ?? "")) {
                        nextPage = home;
                      }
                      if (context.mounted) {
                        context.goNamed(nextPage);
                      }
                    } else {
                      print(value);
                    }
                  }
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },

                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                    color: MyTheme.primaryContainerLight.withOpacity(0.6),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const MyText(
              "Didn't get the code?",
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                color: MyTheme.primary,
                fontSize: 14,
                fontFamily: "Roboto",
              ),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: "login_btn",
              child: MyButton(
                onTap: () async {
                  if (widget.mobile == null) {
                    context.goNamed(login);
                    return;
                  }
                  await _authController.resendOTP(context, widget.mobile!);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Resend"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
