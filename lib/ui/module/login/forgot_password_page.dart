import 'package:broking/ui/module/login/set_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import '../../../controllers/login/login_forgot_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';

class ForgotPasswordPage extends AppPageWithAppBar {
  static const String routeName = "/ForgotPasswordPage";

  ForgotPasswordPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }

  final controller = Get.put(ForgotOtpController());

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(

            width: screenWidget,
            height: screenHeight,
            decoration: const BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.30, 0.70],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  Palette.backgroundBgTopLeft,
                  Palette.backgroundBgBottomLeft,
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 30,),
                InkWell(onTap: (){Get.back();},child: Align(alignment: Alignment.centerLeft,child:
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 0,top: 20),
                  child: SvgPicture.asset(width:22,height: 22,'assets/png/back_bar.svg'),
                ),
                ),),
                const SizedBox(height: 90,),

                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30,top: 20),
                      child: Column(

                        children: <Widget>[
                          SizedBox(
                            height: screenHeight / 4,
                            child: Center(
                              child: companyLogo,
                            ),
                          ),
                          Obx(() => controller.isVerified.value?Text(
                            "OTP Verification",
                            style: TextStyles.headingTexStyle(
                              color: Palette.kColorWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat',
                            ),
                          ):Text(
                            "Forgot Your Password?",
                            style: TextStyles.headingTexStyle(
                              color: Palette.kColorWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat',
                            ),
                          )),
                          const SizedBox(height: 10,),
                          Obx(() => controller.isVerified.value?Text("Enter the OTP that has to be sent at your email address",
                            textAlign: TextAlign.center,
                            style: TextStyles.headingTexStyle(
                              color: Palette.kColorWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat',
                            ),
                          ):Text(
                            "Enter your email address and you will receive an OTP for reset your password",
                            textAlign: TextAlign.center,
                            style: TextStyles.headingTexStyle(
                              color: Palette.kColorWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Montserrat',
                            ),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() => controller.isVerified.value?const SizedBox.shrink():email),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    otpField,

                                    const SizedBox(
                                      height: 10,
                                    ),
                                    loginButton(screenWidget, controller.isVerified),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    Obx(() => controller.isVerified.value?resendText:const SizedBox.shrink())
                                  ],
                                ),
                              ),
                            ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Palette.appColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  Widget get otpField {
    return Obx(() => controller.isVerified.value
        ? VerificationCode(
            textStyle: const TextStyle(fontSize: 20.0, color: Palette.kColorWhite),
            keyboardType: TextInputType.number,
            underlineColor: Colors.amber,
            // If this is null it will use primaryColor: Colors.red from Theme
            length: 4,
            cursorColor: Palette.kColorWhite,
            // If this is null it will default to the ambient
            // clearAll is NOT required, you can delete it
            // takes any widget, so you can implement your design
            clearAll: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'clear all',
                style: TextStyle(
                    fontSize: 14.0,
                    decoration: TextDecoration.underline,
                    color: Palette.kColorWhite),
              ),
            ),
            onCompleted: (String value) {
              controller.code.value = value;
            },
            onEditing: (bool value) {},
          )
        : const SizedBox.shrink());
  }

  /*_onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      }else{
        _enableButton = false;
      }
    });
  }*/

  Widget get resendText {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't receive otp?",
            style: TextStyles.headingTexStyle(
              color: MyColors.kColorWhite,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            ),
          ),
          InkWell(
            onTap: () {
              //Home.start();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: SizedBox(
                height: 20,
                child: InkWell(
                  onTap: () {
                    controller.forgotApi();
                  },
                  child: Text(
                    " Resend",
                    style: TextStyles.headingTexStyle(
                      color: Palette.kColorWhite,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get enterMobileNUmberText {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 20,
          child: Text(
            "Resend",
            style: TextStyles.headingTexStyle(
              color: MyColors.kColorGrey,
              fontSize: 15,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }

  Widget get labelText {
    return SizedBox(
      height: 20,
      child: Text(
        "We'll send you a verification code on the mobile number",
        style: TextStyles.labelTextStyle(color: Palette.colorTextGrey),
      ),
    );
  }

  Widget get email {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: TextField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
        controller: controller.emailController,
        decoration:  const InputDecoration(
            hintText: "Enter your email address",
            labelText: "Email Address",
            labelStyle: TextStyle( color: Palette.colorWhite,fontWeight: FontWeight.w100),
            hintStyle: TextStyle(
                color: Palette.colorWhite,fontSize: 15,fontWeight: FontWeight.w300
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: .50),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white,width: .5),
            ),

        ),

      ),
    );
  }

  Widget get companyLogo {
    return Obx(() => controller.isVerified.value?SvgPicture.asset(
        width: 150, height: 150, 'assets/svg/otp.svg'):SvgPicture.asset(
        width: 150, height: 150, 'assets/svg/lock.svg'));
  }

  Widget loginButton(double screenWidget, RxBool isVerified) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: Obx(() =>
            PrimaryElevatedBtn(isVerified.value ? "VERIFY" : "SUBMIT", () {
              if (isVerified.value) {
                controller.otpVerifyApi(controller.code.value);
              } else {
                controller.forgotApi();
              }
            }, borderRadius: 10.0)),
      ),
    );
  }

  Widget get skipText {
    return InkWell(
      onTap: () {
        //Home.start();
      },
      child: SizedBox(
        height: 20,
        child: Text(
          "Forgot password",
          style: TextStyles.headingTexStyle(
            color: MyColors.appColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
}
