import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:opticash/core/widgets/app_button.dart';
import 'package:opticash/core/widgets/app_text.dart';
import 'package:opticash/core/widgets/custom_appbar.dart';
import 'package:opticash/features/views/authentication/sign_in_screen.dart';
import 'package:opticash/features/views/authentication/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const route = "onboarding_screen";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          bgColor: Colors.black,
          height: 20,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("assets/images/pattern.png"),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Spacer(),
              Image.asset("assets/images/onboarding.png"),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 44.0, bottom: 12),
                child: AppText(
                  "Send Money faster than imagined",
                  size: 30,
                  height: 1.2,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 44.0, bottom: 32),
                child: AppText(
                  "Opticash provides you the fastest remittance to send and receive money!",
                  size: 14,
                  weight: FontWeight.normal,
                  height: 1.2,
                  family: "Poppins",
                  color: Color(0xFFCFCFCF),
                ),
              ),
              Row(
                children: [
                  for (var i = 0; i < 3; i++)
                    Container(
                      width: 68,
                      height: 2,
                      color: i == 0 ? Color(0xFFC1D138) : Color(0xFFA0A0A0),
                      margin: EdgeInsets.only(right: 8),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 13),
                child: AppButton.elevated(
                  onTap: () => Navigator.pushNamed(context, SignUpScreen.route),
                  text: "Create New Account",
                  gradientColors: [Color(0xFFA3CB00), Color(0xFFDDDA4C)],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Sign In",
                  style: TextStyle(
                    fontFamily: "Rogerex",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () => Navigator.pushNamed(context, SignInScreen.route),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
