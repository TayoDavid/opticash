import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opticash/core/model/auth_models.dart';
import 'package:opticash/core/utils/message.dart';
import 'package:opticash/core/widgets/app_button.dart';
import 'package:opticash/core/widgets/app_text.dart';
import 'package:opticash/core/widgets/app_text_field.dart';
import 'package:opticash/core/widgets/custom_appbar.dart';
import 'package:opticash/features/blocs/authentication/authentication_bloc.dart';
import 'package:opticash/features/views/authentication/sign_up_screen.dart';
import 'package:opticash/features/views/home/home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const route = "Sign_in_screen";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;

  @override
  void initState() {
    _emailFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(hasLeading: true, bgColor: Colors.white),
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/money_pattern.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    action: TextInputAction.next,
                    type: TextInputType.emailAddress,
                    onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                    validate: (str) {
                      if (str == null || str.isEmpty) {
                        return 'Email field required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 22),
                  AppTextField(
                    label: "Password",
                    hint: "Enter Password",
                    focusNode: _passwordFocusNode,
                    obscureText: _obscurePassword,
                    controller: _passwordController,
                    onFieldSubmitted: (_) => _signIn(),
                    suffix: IconButton(
                      icon: Icon(CupertinoIcons.eye),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validate: (str) {
                      if (str == null || str.isEmpty) {
                        return 'Password field required';
                      }
                      return null;
                    },
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
                  BlocConsumer<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      if (state is Authenticated) {
                        Navigator.pushReplacementNamed(context, HomeScreen.route);
                      }
                      if (state is AuthenticationError) {
                        errorMessage(context, state.errMsg);
                      }
                    },
                    builder: (context, state) {
                      return AppButton.elevated(
                        onTap: _signIn,
                        text: "SIGN IN",
                        isLoading: state is Authenticating,
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xff0b0b0b),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final body = LoginModel(
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text.trim(),
      );
      final authBloc = context.read<AuthenticationBloc>();
      authBloc.add(Login(body));
    }
  }
}
