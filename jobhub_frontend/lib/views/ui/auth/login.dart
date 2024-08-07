import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/login_provider.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/signup.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            text: "Login",
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
                text: "Welcome Back!",
                style: appstyle(30, Color(kDark.value), FontWeight.w600),
              ),
              ReusableText(
                text: "Fill the deatils to login to your account",
                style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
              ),
              const HeightSpacer(size: 50),

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
                obscureText: loginNotifier.obscureText,
                validator: (password) {
                  if (password!.isEmpty || password.length < 7) {
                    return "Password cannot be empty";
                  } else {
                    return null;
                  }
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    loginNotifier.obscureText = !loginNotifier.obscureText;
                  },
                  child: Icon(
                    loginNotifier.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(kDark.value),
                  ),
                ),
              ),
              const HeightSpacer(size: 10),

              /// Register
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const RegistrationPage());
                  },
                  child: ReusableText(
                    text: "Register",
                    style: appstyle(14, Color(kDark.value), FontWeight.w500),
                  ),
                ),
              ),
              const HeightSpacer(size: 50),

              /// Login Button
              CustomButton(
                onTap: () {
                  Get.to(() => const MainScreen());
                },
                text: "Login",
              )
            ],
          ),
        ),
      );
    });
  }
}
