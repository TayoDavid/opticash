import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:opticash/core/widgets/app_button.dart';
import 'package:opticash/core/widgets/app_text.dart';
import 'package:opticash/core/widgets/app_text_field.dart';
import 'package:opticash/core/widgets/custom_appbar.dart';
import 'package:opticash/features/views/authentication/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const route = "Sign_in_screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(hasLeading: true, bgColor: Colors.white),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              "Sign In",
              size: 30,
              weight: FontWeight.w600,
              color: Color(0xFF46531F),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 34, right: 44),
              child: AppText(
                "Sign In to your account using your email address and password",
                size: 14,
                weight: FontWeight.normal,
                family: "Poppins",
                height: 1.4,
                color: Color(0xFF9E9E9E),
              ),
            ),
            AppTextField(
              label: "Email",
              hint: "Enter Email",
            ),
            SizedBox(height: 22),
            AppTextField(
              label: "Password",
              hint: "Enter Password",
              obscureText: true,
            ),
            Container(
              padding: EdgeInsets.only(top: 31),
              width: double.infinity,
              child: AppText(
                "Forgot Password?",
                size: 14,
                color: Color(0xFF9E9E9E),
                align: TextAlign.center,
                family: "Poppins",
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Poppins",
                    color: Color(0xff9e9e9e),
                  ),
                  text: "Don’t have account? ",
                  children: [
                    TextSpan(
                      text: "Create Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff46531f),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, SignUpScreen.route),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            AppButton.elevated(
              onTap: () {},
              text: "SIGN IN",
              foregroundColor: Colors.white,
              backgroundColor: Color(0xff0b0b0b),
            ),
          ],
        ),
      ),
    );
  }
}
