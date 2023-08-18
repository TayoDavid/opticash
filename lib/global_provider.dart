import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:opticash/core/api/services/authentication_service.dart';
import 'package:opticash/features/blocs/authentication/authentication_bloc.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthenticationBloc(AuthenticationService()),
      child: child,
    );
  }
}
