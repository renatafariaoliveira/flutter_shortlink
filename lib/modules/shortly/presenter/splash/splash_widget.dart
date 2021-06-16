import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shortlink/modules/utils/body_text_widget.dart';
import 'package:flutter_shortlink/modules/utils/colors.dart';
import 'package:flutter_shortlink/modules/utils/logo_image.dart';
import 'package:flutter_shortlink/modules/utils/primary_button.dart';
import 'package:flutter_shortlink/modules/utils/primary_image.dart';
import 'package:flutter_shortlink/modules/utils/title_widget.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundWhiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 39.h),
            LogoImageWidget(),
            SizedBox(height: 60.h),
            PrimaryImageWidget(),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              child: Column(
                children: [
                  CustomTitleText(text: 'More than just shorter links'),
                  SizedBox(height: 10.h),
                  CustomBodyText(text: 'Build your brand’s recognition and get detailed insights on how your links are performing.'),
                  SizedBox(height: 49.h),
                  CustomPrimaryButton(
                    text: 'Start',
                    press: () => Modular.to.pushNamed('/onboarding'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
