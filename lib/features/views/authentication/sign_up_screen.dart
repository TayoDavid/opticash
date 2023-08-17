import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:opticash/core/widgets/app_button.dart';
import 'package:opticash/core/widgets/app_text.dart';
import 'package:opticash/core/widgets/app_text_field.dart';
import 'package:opticash/core/widgets/custom_appbar.dart';
import 'package:opticash/features/views/authentication/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const route = "Sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              "Create Account",
              size: 30,
              weight: FontWeight.w600,
              color: Color(0xFF46531F),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 34, right: 44),
              child: AppText(
                "Register a new account using your email address and fill in your informations",
                size: 14,
                weight: FontWeight.normal,
                family: "Poppins",
                height: 1.4,
                color: Color(0xFF9E9E9E),
              ),
            ),
            AppTextField(
              label: "First Name",
              hint: "Enter First Name",
            ),
            SizedBox(height: 22),
            AppTextField(
              label: "Last Name",
              hint: "Enter Last Name",
            ),
            SizedBox(height: 22),
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
            Padding(
              padding: EdgeInsets.only(left: 20, top: 15, bottom: 41),
              child: Row(
                children: [
                  for (var i = 0; i < 4; i++)
                    Container(
                      width: 18,
                      height: 4,
                      color: i != 3 ? Color(0xFF769c00) : Color(0xFFd9d9d9),
                      margin: EdgeInsets.only(right: 8),
                    ),
                ],
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
                  text: "Already have an account? ",
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff46531f),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, SignInScreen.route),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            AppButton.elevated(
              onTap: _showSuccessDialog,
              text: "CREATE NEW ACCOUNT",
              foregroundColor: Colors.white,
              backgroundColor: Color(0xff0b0b0b),
            ),
            SizedBox(height: 13),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 64),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Poppins",
                    color: Color(0xff9e9e9e),
                  ),
                  text: "By signing up you agree to our ",
                  children: [
                    TextSpan(
                      text: "Term Of Use",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff46531f),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff46531f),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 280),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 37),
              Image.asset(
                "assets/images/logo.png",
                width: 79,
                height: 93,
              ),
              Padding(
                padding: EdgeInsets.only(top: 13.0, left: 44, right: 44, bottom: 19),
                child: AppText(
                  "Account Created Successfully",
                  weight: FontWeight.w600,
                  align: TextAlign.center,
                  color: Color(0xff101010),
                ),
              ),
              AppButton.elevated(
                onTap: () => Navigator.pushReplacementNamed(context, SignInScreen.route),
                text: "SIGN IN",
                foregroundColor: Colors.white,
                backgroundColor: Color(0xff627122),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
