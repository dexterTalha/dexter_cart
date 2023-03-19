import 'package:country_picker/country_picker.dart';
import 'package:dexter_cart/auth/auth_controller.dart';
import 'package:dexter_cart/components/primary_widget.dart';
import 'package:dexter_cart/utils/image_url.dart';
import 'package:dexter_cart/utils/my_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final AuthController _authController = AuthController.instance;
  String code = "";
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void initState() {
    if (_authController.user != null) {
      _phoneController.text = _authController.user?.phoneNumber ?? "";
      _nameController.text = _authController.user?.displayName ?? "";
      _emailController.text = _authController.user?.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryWidget(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: const MyText("Sign Up"),
        centerTitle: true,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  ImageUrl.assetsSignUp,
                ),
                MyTextField(
                  label: "Enter Name",
                  controller: _nameController,
                  borderRadius: BorderRadius.circular(8),
                  inputType: TextInputType.number,
                  validator: (st) {
                    if (st == null || st.isEmpty) {
                      return "This field is required";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                MyTextField(
                  label: "Enter Email",
                  controller: _emailController,
                  borderRadius: BorderRadius.circular(8),
                  inputType: TextInputType.number,
                  validator: (st) {
                    if (st == null || st.isEmpty) {
                      return "This field is required";
                    }
                    if (!st.isEmail) {
                      return 'Invalid Email';
                    }

                    return null;
                  },
                ),
                Visibility(
                  visible: _authController.user?.phoneNumber == null,
                  child: const SizedBox(height: 10),
                ),
                Visibility(
                  visible: _authController.user?.phoneNumber == null,
                  child: MyTextField(
                    controller: _countryController,
                    label: "Country/Region",
                    isReadOnly: true,
                    // prefixWidget: ,
                    validator: (st) {
                      if (st == null || st.isEmpty) {
                        return "This field is required";
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
                        countryListTheme: const CountryListThemeData(
                          flagSize: 35,
                          bottomSheetHeight: double.maxFinite * 0.8,
                        ),
                        onSelect: (Country country) {
                          print('Select country: ${country.flagEmoji}');
                          _countryController.text = "${country.flagEmoji} ${country.name}(+${country.phoneCode})";
                          code = country.phoneCode;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  label: "Enter Phone Number",
                  controller: _phoneController,
                  borderRadius: BorderRadius.circular(8),
                  inputType: TextInputType.number,
                  validator: (st) {
                    if (st == null || st.isEmpty) {
                      return "This field is required";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => Visibility(
                      visible: _authController.isUserCreating.value,
                      replacement: Hero(
                        tag: "sign_up",
                        child: MyButton(
                          onTap: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String countryCode = "";
                            if (_authController.user?.phoneNumber == null) {
                              countryCode = "+$code";
                            }
                            String mobile = "$countryCode${_phoneController.text}";

                            bool result = await _authController.insertUser(mobile: mobile, email: email, name: name);
                            if (result && context.mounted) {
                              context.goNamed(home);
                            }
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
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
