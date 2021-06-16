import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shortlink/modules/utils/colors.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String text;
  final Function press;
  final double height;
  final double fontSize;
  final Color color;
  CustomPrimaryButton({required this.text, required this.press, this.height = 49, this.fontSize = 20, this.color = CustomColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: 279.w,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: () => press(),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
