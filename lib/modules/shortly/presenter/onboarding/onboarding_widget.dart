import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/card_entity.dart';
import 'package:flutter_shortlink/modules/utils/logo_image.dart';
import 'package:flutter_shortlink/modules/utils/onboarding_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_shortlink/modules/utils/colors.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPagePageState createState() => _OnboardingPagePageState();
}

class _OnboardingPagePageState extends State<OnboardingPage> {
  int _current = 0;

  Padding _buildCard(CustomCard card) {
    return Padding(
      padding: EdgeInsets.only(
        top: 80.h,
        right: 25.w,
        left: 25.w,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 44),
            width: 325.w,
            height: 300.h,
            decoration: BoxDecoration(
              color: CustomColors.backgroundWhiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    card.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.neutralGrayishVioletColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    card.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColors.neutralGrayishVioletColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            radius: 44.0,
            backgroundColor: CustomColors.primaryColor,
            child: SvgPicture.asset(
              card.icon,
              height: 40,
              width: 40,
              color: CustomColors.backgroundOffWhiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildSlide(List<CustomCard> item) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 380.h,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: item.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return _buildCard(i);
              },
            );
          }).toList(),
        ),
        SizedBox(height: 28.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: item.map((card) {
            int index = item.indexOf(card);
            return Container(
              width: 10.w,
              height: 10.w,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? CustomColors.neutralGrayColor : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundOffWhiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: LogoImageWidget(),
            ),
            SizedBox(height: 14.h),
            _buildSlide(onboardingCardData),
            SizedBox(height: 107),
            Padding(
              padding: EdgeInsets.only(left: 25.w, right: 25.w),
              child: GestureDetector(
                onTap: () => Modular.to.pushNamed('/home'),
                child: Container(
                  width: 279.w,
                  height: 22.h,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: CustomColors.neutralVeryDarkVioletColor,
                      fontSize: 17.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
