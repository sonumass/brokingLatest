import 'package:broking/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../controllers/login/login_forgot_controller.dart';
import '../../../services/navigator.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/primary_elevated_button.dart';

class ChangePasswordPage extends AppPageWithAppBar {
  static const String routeName = "/ChangePasswordPage";

  ChangePasswordPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>(String email) {
    return navigateTo<bool>(routeName,arguments: {"email":email});
  }
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(ForgotOtpController());
  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Scaffold(
        backgroundColor: Palette.backgroundBg,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
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
            ),child: Column(
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
                child:  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        newPassword,
                        confirmPassword,
                        const SizedBox(
                          height: 10,
                        ),
                        loginButton()
                      ],
                    ),

                ),
              )
            ],
          ),),
        ));
  }



  Widget get newPassword {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: TextField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
        controller: passwordController,
        decoration: const InputDecoration(
            hintText: "Enter new password",
            labelText: "New password",
            hintStyle: TextStyle(color: Palette.kColorGrey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .50),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .5),
            ),
            labelStyle: TextStyle(color: Palette.kColorGrey)),
      ),
    );
  }

  Widget get confirmPassword {
    return  Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: TextField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
        controller: confirmPasswordController,
        decoration: const InputDecoration(
            hintText: "Enter confirm password",
            labelText: "Confirm password",
            hintStyle: TextStyle(color: Palette.kColorGrey),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .50),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .5),
            ),
            labelStyle: TextStyle(color: Palette.kColorGrey)),
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
  Widget  loginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "Set Password",
                () {
              if(!passwordController.text.isNotEmpty){
                Common.showToast("Please enter password");
                return;
              }
              if(!confirmPasswordController.text.isNotEmpty){
                Common.showToast("Please enter confirm password");
                return;
              }
              if(confirmPasswordController.text!=passwordController.text){
                Common.showToast("Please enter confirm did not match");
                return;
              }
                  controller.resetPasswordApi(arguments["email"], confirmPasswordController.text);

            },
            borderRadius: 10.0),
      ),
    );
  }
}
