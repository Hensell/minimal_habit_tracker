import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.color,
    this.width,
    this.height = 40,
    required this.text,
    this.borderRadius = 25,
  });

  final VoidCallback onPressed;
  final Color color;
  final double? width;
  final double height;
  final Widget text;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius), color: color),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
            backgroundColor: Colors.transparent,
            disabledForegroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
          ),
          child: text),
    );
  }
}
