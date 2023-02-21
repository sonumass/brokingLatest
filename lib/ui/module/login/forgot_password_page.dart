import 'package:broking/ui/module/login/set_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:get/get.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
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

  final isVerified = false.obs;
  final _code = "".obs;

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: screenHeight / 3,
                child: Center(
                  child: companyLogo,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        email,
                        const SizedBox(
                          height: 10,
                        ),
                        otpField,
                        const SizedBox(
                          height: 10,
                        ),
                        resendText,
                        const SizedBox(
                          height: 10,
                        ),
                        loginButton(screenWidget, isVerified),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
    return VerificationCode(
      textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
      keyboardType: TextInputType.number,
      underlineColor: Colors.amber,
      // If this is null it will use primaryColor: Colors.red from Theme
      length: 4,
      cursorColor: Colors.blue,
      // If this is null it will default to the ambient
      // clearAll is NOT required, you can delete it
      // takes any widget, so you can implement your design
      clearAll: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'clear all',
          style: TextStyle(
              fontSize: 14.0,
              decoration: TextDecoration.underline,
              color: Colors.blue[700]),
        ),
      ),
      onCompleted: (String value) {
        _code.value = value;
      },
      onEditing: (bool value) {},
    );
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
              color: MyColors.appColor,
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
                child: Text(
                  "Resend",
                  style: TextStyles.headingTexStyle(
                    color: MyColors.appColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
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
        textAlign: TextAlign.left,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: const Icon(Icons.email_rounded),
          hintText: 'Enter your email ',
          filled: true,
          contentPadding: const EdgeInsets.all(16),
          fillColor: Colors.white,
        ),
      ),
    );
  }



  Widget get companyLogo {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.asset("assets/png/app_logo.png"),
    );
  }

  Widget loginButton(double screenWidget, RxBool isVerified) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: Obx(() =>
            PrimaryElevatedBtn(isVerified.value ? "Verify" : "Get OTP", () {
              if(isVerified.value)ChangePasswordPage.start();
              isVerified.value = true;

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
