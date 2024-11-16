import 'package:flutter/material.dart';

class CustomButtonFilled extends StatelessWidget {
  const CustomButtonFilled({
    super.key,
    required this.title,
    required this.onPressed,
    this.widget,
    this.borderRadius = 18,
    this.height = 50,
    this.width = double.maxFinite,
    this.titleCenter = true,
    this.disabled = false,
    this.titleColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF042F4D),
  });

  final String title;
  final VoidCallback onPressed;
  final double borderRadius;
  final double height;
  final double width;
  final List<Widget>? widget;
  final Color titleColor;
  final Color backgroundColor;
  final bool titleCenter;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          overlayColor: backgroundColor.withOpacity(0.5),
          elevation: 0,
          backgroundColor: disabled ? backgroundColor.withOpacity(0.8) : backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: titleCenter ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            ...?widget,
          ],
        ),
      ),
    );
  }
}
