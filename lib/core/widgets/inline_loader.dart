import 'package:flutter/material.dart';

class InlineLoader extends StatelessWidget {
  final double size;
  final Color strokeColor;

  InlineLoader({super.key, this.size = 20, this.strokeColor = const Color(0xFF94C419)});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        backgroundColor: Colors.white,
        strokeWidth: 1.5,
        valueColor: AlwaysStoppedAnimation<Color?>(strokeColor),
      ),
    );
  }
}
