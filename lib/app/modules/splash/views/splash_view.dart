import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/constants/color_constant.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetWidget<SplashController> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.backgroundTheme,
        body: Container(
          height: MySize.screenHeight,
          width: MySize.screenWidth,

          // color: appTheme.primaryTheme,
          child: Column(
            children: [
              Spacing.height(145),
              SvgPicture.asset(
                "assets/splash_01_01.svg",
                width: MySize.getWidth(100),
                height: MySize.getHeight(100),
                fit: BoxFit.cover,
                color: appTheme.primaryTheme,
              ),
              SvgPicture.asset(
                "assets/splash_02_02.svg",
                width: MySize.getWidth(118),
                height: MySize.getHeight(45),
                fit: BoxFit.cover,
                color: appTheme.primaryTheme,
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/splash_image_01.png",
                  width: MySize.getWidth(360),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
