import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../components/button_widget.dart';
import '../components/my_text.dart';
import '../utils/my_theme.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

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
                validator: (value) {
                  return value == '2222' ? null : 'Pin is incorrect';
                },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
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
                onTap: () {
                  context.goNamed(MyRoutes.signUp);
                  // final snackBar = SnackBar(
                  //   /// need to set following properties for best effect of awesome_snackbar_content
                  //   elevation: 0,

                  //   behavior: SnackBarBehavior.floating,
                  //   backgroundColor: Colors.transparent,
                  //   dismissDirection: DismissDirection.horizontal,

                  //   duration: const Duration(seconds: 2),
                  //   content: AwesomeSnackbarContent(
                  //     title: 'On Snap!',
                  //     message: 'This is an example error message that will be shown in the body of snackbar!',

                  //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                  //     contentType: ContentType.help,
                  //   ),
                  //   margin: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).size.height - 190,
                  //     right: 1,
                  //     left: 60,
                  //   ),
                  // );

                  // ScaffoldMessenger.of(context)
                  //   ..hideCurrentSnackBar()
                  //   ..showSnackBar(snackBar);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
