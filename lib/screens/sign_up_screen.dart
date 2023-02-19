import 'package:country_picker/country_picker.dart';
import 'package:dexter_cart/components/primary_widget.dart';
import 'package:flutter/material.dart';

import '../components/button_widget.dart';
import '../components/my_text.dart';
import '../components/my_text_field.dart';
import '../utils/my_theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryWidget(
      padding: EdgeInsets.zero,
      appBar: AppBar(),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              label: "Enter Name",
              borderRadius: BorderRadius.circular(8),
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
            MyTextField(
              label: "Enter Email",
              borderRadius: BorderRadius.circular(8),
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
            MyTextField(
              // controller: _countryController,
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
                    bottomSheetHeight: double.maxFinite * 0.8,
                  ),
                  onSelect: (Country country) {
                    print('Select country: ${country.flagEmoji}');
                    // _countryController.text = "${country.flagEmoji} ${country.name}(+${country.phoneCode})";
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            MyTextField(
              label: "Enter Phone Number",
              borderRadius: BorderRadius.circular(8),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Hero(
                tag: "sign_up",
                child: MyButton(
                  onTap: () {
                    // context.goNamed(MyRoutes.otpScreen);
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
                  child: const Center(
                    child: MyText(
                      "Sign Up",
                      textStyle: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
