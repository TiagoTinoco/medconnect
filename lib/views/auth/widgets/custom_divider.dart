import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: CustomColors.primary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'ou',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: CustomColors.primary,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: 1,
            thickness: 1,
            color: CustomColors.primary,
          ),
        ),
      ],
    );
  }
}
