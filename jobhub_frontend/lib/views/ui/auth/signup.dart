import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/signup_provider.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/reusable_text.dart';
import 'package:jobhub/views/ui/auth/login.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpNotifier>(builder: (context, signupNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            text: "Sign Up",
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const HeightSpacer(size: 50),
              ReusableText(
                text: "Hello, Welcome!",
                style: appstyle(30, Color(kDark.value), FontWeight.w600),
              ),
              ReusableText(
                text: "Fill the details for sign up to your account",
                style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
              ),
              const HeightSpacer(size: 50),

              /// Name TextField
              CustomTextField(
                controller: name,
                keyboardType: TextInputType.name,
                hintText: "Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              const HeightSpacer(size: 20),

              /// Email TextField
              CustomTextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  } else if (!value.isEmail) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const HeightSpacer(size: 20),

              /// Password TextField
              CustomTextField(
                controller: password,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Password",
                obscureText: signupNotifier.obscureText,
                validator: (password) {
                  if (signupNotifier.passwordValidator(password ?? "")) {
                    return "Please enter a valid password with at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character";
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    signupNotifier.obscureText = !signupNotifier.obscureText;
                  },
                  child: Icon(
                    signupNotifier.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(kDark.value),
                  ),
                ),
              ),
              const HeightSpacer(size: 10),

              /// Login
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  child: ReusableText(
                    text: "Login",
                    style: appstyle(14, Color(kDark.value), FontWeight.w500),
                  ),
                ),
              ),
              const HeightSpacer(size: 50),

              /// Sign Up Button
              CustomButton(
                onTap: () {},
                text: "Sign Up",
              )
            ],
          ),
        ),
      );
    });
  }
}
