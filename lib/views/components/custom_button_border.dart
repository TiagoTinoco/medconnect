import 'package:flutter/material.dart';

class CustomButtonBorder extends StatelessWidget {
  const CustomButtonBorder({
    super.key,
    this.titleSize = 18,
    this.height = 50,
    this.width = double.maxFinite,
    this.color = const Color(0xFF042F4D),
    this.titleColor = const Color(0xFF042F4D),
    required this.title,
    required this.onPressed,
  });

  final String title;
  final double titleSize;
  final double height;
  final double width;
  final Color titleColor;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          overlayColor: color.withOpacity(0.5),
          backgroundColor: const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          side: BorderSide(
            width: 2,
            color: color,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            color: titleColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
