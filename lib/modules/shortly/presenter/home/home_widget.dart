import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shortlink/modules/shortly/domain/entities/link_entity.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_bloc.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_event.dart';
import 'package:flutter_shortlink/modules/shortly/presenter/home/home_state.dart';
import 'package:flutter_shortlink/modules/utils/body_text_widget.dart';
import 'package:flutter_shortlink/modules/utils/colors.dart';
import 'package:flutter_shortlink/modules/utils/logo_image.dart';
import 'package:flutter_shortlink/modules/utils/primary_button.dart';
import 'package:flutter_shortlink/modules/utils/primary_image.dart';
import 'package:flutter_shortlink/modules/utils/title_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeBloc> {
  late TextEditingController _inputLink;
  bool _validate = false;
  List<LinkEntity> _links = [];
  late UniqueKey _uniqueKey;

  @override
  void initState() {
    _inputLink = TextEditingController();
    _uniqueKey = UniqueKey();
    super.initState();
  }

  @override
  void dispose() {
    _inputLink.dispose();
    super.dispose();
  }

  CustomPrimaryButton _buildShortenButton() {
    return CustomPrimaryButton(
      text: 'Shorten It!',
      press: () {
        setState(() {
          _validate = _inputLink.text.isEmpty ? true : false;
        });

        if (!_validate) {
          controller.add(ShortEvent(_inputLink.text));
        }
      },
    );
  }

  Container _buildBottomButtons(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 204.h,
      color: CustomColors.neutralGrayishVioletColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Opacity(
              opacity: .1,
              child: SvgPicture.asset(
                'assets/images/shape.svg',
                color: CustomColors.neutralGrayColor,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 49.h,
                  width: 279.w,
                  child: TextField(
                    controller: _inputLink,
                    onTap: () async {
                      final ClipboardData? _data = await Clipboard.getData('text/plain');
                      _inputLink.text = _data!.text!;
                      controller.add(StartEvent());
                      setState(() {});
                    },
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: _validate ? CustomColors.secondaryRedColor : Colors.transparent),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: _validate ? CustomColors.secondaryRedColor : Colors.transparent),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: _validate ? 'Please add a link here' : 'Shorten a link here ...',
                      hintStyle: TextStyle(
                        color: _validate ? CustomColors.secondaryRedColor : CustomColors.neutralLightGrayColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                StreamBuilder<HomeState>(
                  stream: controller.stream,
                  builder: (context, snapshot) {
                    final _state = controller.state;

                    if (_state is HomeStartState) {
                      return _buildShortenButton();
                    } else if (_state is HomeLoadingState) {
                      return SizedBox(
                        height: 49.h,
                        width: 279.w,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: CustomColors.neutralGrayColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: () {},
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      );
                    } else if (_state is HomeFailureState) {
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              _state.error.message,
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: CustomColors.secondaryRedColor,
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      });

                      return _buildShortenButton();
                    } else if (_state is HomeSuccessState) {
                      controller.add(RetrieveLinksEvent());
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        _inputLink.clear();
                      });

                      return _buildShortenButton();
                    } else if (_state is HomeRetrieveLinksState) {
                      _links = _state.links;
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        setState(() {});
                      });

                      return _buildShortenButton();
                    } else if (_state is HomeDeleteLinkState) {
                      _links = _state.links;
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        setState(() {});
                      });
                      return _buildShortenButton();
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildFirstRun() {
    return Column(
      children: [
        SizedBox(height: 39.h),
        LogoImageWidget(),
        SizedBox(height: 60.h),
        PrimaryImageWidget(),
        SizedBox(height: 30),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            children: [
              CustomTitleText(
                text: 'Let’s get started!',
                fontSize: 20,
              ),
              SizedBox(height: 7.h),
              Container(
                width: 225.w,
                child: CustomBodyText(text: 'Paste your first link into the field to shorten it'),
              ),
              SizedBox(height: 69.h),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildLinkCard(LinkEntity link) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 20.h),
      child: Container(
        padding: EdgeInsets.only(bottom: 23.h, top: 23.h),
        height: 180.h,
        width: 325.w,
        decoration: BoxDecoration(
          color: CustomColors.backgroundWhiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 23.w, left: 23.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      link.originalLink,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: CustomColors.neutralGrayishVioletColor,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () => controller.add(DeleteLinkEvent(link.id)),
                    child: SvgPicture.asset(
                      'assets/images/del.svg',
                      width: 14.w,
                      height: 18.h,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: CustomColors.neutralLightGrayColor,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 23.h, right: 23.w, left: 23.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      link.shortLink,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: 17.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 23.w, left: 23.w),
              child: CustomPrimaryButton(
                text: _uniqueKey == link.id ? 'Copied!' : 'Copy',
                height: 39,
                fontSize: 17,
                color: _uniqueKey == link.id ? CustomColors.primaryDarkVioletColor : CustomColors.primaryColor,
                press: () async {
                  final ClipboardData _data = ClipboardData(text: link.shortLink);
                  await Clipboard.setData(_data);
                  setState(() {
                    _uniqueKey = link.id;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildList(List<LinkEntity> items) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.h, top: 50.h),
            child: CustomBodyText(text: 'Your Link History'),
          ),
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return _buildLinkCard(items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundOffWhiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _links.length > 0 ? _buildList(_links) : _buildFirstRun(),
            _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }
}
