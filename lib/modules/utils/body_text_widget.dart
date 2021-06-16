import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shortlink/modules/utils/colors.dart';

class CustomBodyText extends StatelessWidget {
  final String text;
  CustomBodyText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 17.sp,
        color: CustomColors.neutralGrayishVioletColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
