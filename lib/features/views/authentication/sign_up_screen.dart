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
import 'package:opticash/features/views/authentication/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const route = "Sign_up_screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _obscurePassword = true;

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
                  focusNode: _firstNameFocusNode,
                  action: TextInputAction.next,
                  onFieldSubmitted: (_) => _lastNameFocusNode.requestFocus(),
                  controller: _firstnameController,
                  validate: (str) {
                    if (str == null || str.isEmpty) {
                      return 'First name field required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22),
                AppTextField(
                  label: "Last Name",
                  hint: "Enter Last Name",
                  focusNode: _lastNameFocusNode,
                  controller: _lastnameController,
                  action: TextInputAction.next,
                  onFieldSubmitted: (_) => _emailFocusNode.requestFocus(),
                  validate: (str) {
                    if (str == null || str.isEmpty) {
                      return 'Last name field required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 22),
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
                  onFieldSubmitted: (_) => _createAccount(),
                  controller: _passwordController,
                  obscureText: _obscurePassword,
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
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is RegistrationSuccessful) {
                      _showSuccessDialog();
                    }
                    if (state is AuthenticationError) {
                      errorMessage(context, state.errMsg);
                    }
                  },
                  builder: (context, state) {
                    return AppButton.elevated(
                      isLoading: state is Authenticating,
                      onTap: () => _createAccount(),
                      text: "CREATE NEW ACCOUNT",
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xff0b0b0b),
                    );
                  },
                ),
                SizedBox(height: 13),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 56),
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

  void _createAccount() async {
    if (_formKey.currentState!.validate()) {
      final body = UserModel(
        firstname: _firstnameController.text.trim(),
        lastname: _lastnameController.text.trim(),
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text.trim(),
      );
      final authBloc = context.read<AuthenticationBloc>();
      authBloc.add(Register(body));
    }
  }
}
