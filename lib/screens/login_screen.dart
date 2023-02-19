import 'package:country_picker/country_picker.dart';
import 'package:dexter_cart/components/button_widget.dart';
import 'package:dexter_cart/components/image_button.dart';
import 'package:dexter_cart/components/my_text.dart';
import 'package:dexter_cart/components/my_text_field.dart';
import 'package:dexter_cart/screens/otp_screen.dart';
import 'package:dexter_cart/utils/image_url.dart';
import 'package:dexter_cart/utils/my_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/my_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Country? selectedCountry;
  bool isTermsAccepted = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///Top image static
                  Image.asset(
                    ImageUrl.parcel,
                    height: size.height * 0.3,
                    width: double.maxFinite,
                  ),

                  const SizedBox(height: 20),

                  ///Text Your Phone Number
                  const MyText(
                    "Your Phone Number",
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: MyTheme.primary,
                      fontSize: 22,
                      fontFamily: "Roboto",
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: _countryController,
                    label: "Country/Region",
                    isReadOnly: true,
                    // prefixWidget: ,
                    validator: (st) {
                      if (st == null) {
                        return "Please Select Country";
                      }
                      if (st.isEmpty) {
                        return "Please Select Country";
                      }
                      return null;
                    },
                    suffixWidget: const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: MyTheme.primary,
                      ),
                    ),
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        favorite: ["IN"],
                        countryListTheme: CountryListThemeData(
                          flagSize: 35,
                          bottomSheetHeight: size.height * 0.8,
                        ),
                        onSelect: (Country country) {
                          print('Select country: ${country.flagEmoji}');
                          _countryController.text = "${country.flagEmoji} ${country.name}(+${country.phoneCode})";
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  MyTextField(
                    controller: _phoneController,
                    label: "Enter Phone Number",
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    inputType: TextInputType.number,
                    validator: (st) {
                      if (st == null) {
                        return "Please input mobile number";
                      }
                      if (st.isEmpty) {
                        return "Please input mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.transparent,
                        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
                      ),
                      child: CheckboxListTile(
                        enableFeedback: false,
                        visualDensity: const VisualDensity(horizontal: -4),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "I have read and accepted the ",
                                style: TextStyle(
                                  color: MyTheme.primary,
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                ),
                              ),
                              TextSpan(
                                text: "Terms of Use",
                                recognizer: TapGestureRecognizer()..onTap = () => print("Hello"),
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: MyTheme.primary,
                                  fontSize: 14,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        value: isTermsAccepted,
                        onChanged: (val) {
                          setState(() {
                            isTermsAccepted = !isTermsAccepted;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Hero(
                      tag: "login_btn",
                      child: MyButton(
                        onTap: () {
                          // if (_formKey.currentState == null) {
                          //   return;
                          // }
                          // if (!_formKey.currentState!.validate()) {
                          //   return;
                          // }
                          context.goNamed(MyRoutes.otpScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primary,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: MyTheme.primaryLight,
                          elevation: 12,
                        ),
                        child: const MyText(
                          "Next",
                          textStyle: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // --------------Or-----------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Stack(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Divider(
                            color: MyTheme.primaryContainerLight,
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(3),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: const MyText(
                              "OR",
                              textStyle: TextStyle(color: MyTheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  //SOCIAL LOGIN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImageButton(
                        ImageUrl.assetsImageGoogle,
                        onTap: () {},
                      ),
                      const SizedBox(width: 20),
                      MyImageButton(
                        ImageUrl.assetsImageFacebook,
                        onTap: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
