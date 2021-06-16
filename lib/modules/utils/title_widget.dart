import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortlink/modules/utils/colors.dart';

class CustomTitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  CustomTitleText({required this.text, this.fontSize = 35});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: CustomColors.neutralGrayishVioletColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
