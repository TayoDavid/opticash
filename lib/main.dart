import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opticash/core/locator/locator_service.dart';
import 'package:opticash/features/views/authentication/sign_in_screen.dart';
import 'package:opticash/features/views/authentication/sign_up_screen.dart';
import 'package:opticash/features/views/home/home_screen.dart';
import 'package:opticash/features/views/onboarding/onboarding_screen.dart';
import 'package:opticash/global_provider.dart';

void main() {
  final app = GlobalProvider(child: const MainApp());
  runApp(app);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    setupLocator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.route,
      routes: {
        OnboardingScreen.route: (context) => OnboardingScreen(),
        SignInScreen.route: (context) => SignInScreen(),
        SignUpScreen.route: (context) => SignUpScreen(),
        HomeScreen.route: (context) => HomeScreen(),
      },
    );
  }
}
