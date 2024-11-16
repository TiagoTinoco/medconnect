import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: CustomColors.primary,
      ),
    );
  }
}
