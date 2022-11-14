import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ivf_project/app/constants/color_constant.dart';
import 'package:ivf_project/app/constants/sizeConstant.dart';
import 'package:ivf_project/app/routes/app_pages.dart';
import 'package:ivf_project/app/utilities/button.dart';
import 'package:ivf_project/app/utilities/text_field.dart';
import 'package:pinput/pinput.dart';

import '../controllers/otp_verification_controller.dart';

class OtpVerificationView extends GetWidget<OtpVerificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: MySize.safeHeight,
          width: MySize.screenWidth,
          color: appTheme.backgroundTheme,
          padding: EdgeInsets.symmetric(horizontal: MySize.getWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "OTP Verification",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: MySize.getHeight(36),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: MySize.getHeight(14)),
                Text(
                    "We have sent you an OTP on Your Mobie number. Please enter below to verify",
                    style: TextStyle(fontSize: MySize.getHeight(14))),
                SizedBox(height: MySize.getHeight(14)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: MySize.getWidth(280),
                        alignment: Alignment.center,
                        child: Pinput(
                          length: 4,
                          controller: controller.pinPutController,
                          defaultPinTheme: PinTheme(
                            width: MySize.getWidth(62),
                            height: MySize.getHeight(74),
                            textStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(30, 60, 87, 1),
                                fontWeight: FontWeight.w600),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(MySize.getHeight(5)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MySize.getHeight(53)),
                InkWell(
                  onTap: () {
                    controller.callOtpVerificationApi(context: context);
                  },
                  child: getButton(text: "Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
