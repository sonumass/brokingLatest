import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/login/login_controller.dart';
import '../../../controllers/login/login_forgot_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../commonWidget/custom_drop_down.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';
import '../../dialog/loader.dart';
import 'forgot_password_page.dart';
class LoginPage extends StatefulWidget {
  static const String routeName = "/login";
  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }

  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginPage> {
  bool _isHidden = true;
  final loginController = Get.put(LoginController());
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  final selectedValue = "Item2".obs;
  double screenWidget = MediaQuery.of(Get.context!).size.width;
  double screenHeight = MediaQuery.of(Get.context!).size.height;


  @override
  Widget build(BuildContext context) {
    return Obx(() => loginController.isLoader.value
        ? const Loader()
        : Container(
      padding: const EdgeInsets.only(left: 30, right: 30,top: 20),
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
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenHeight / 4,
              child: Center(
                child: companyLogo,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "WELCOME!",
              style: TextStyles.headingTexStyle(
                letterSpacing:2,
                color: Palette.kColorWhite,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "An app fit for kings!",
              style: TextStyles.headingTexStyle(
                color: Palette.kColorWhite,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Sign in to continue",
              style: TextStyles.headingTexStyle(
                color: Palette.kColorWhite,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat',
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10, right: 10, top: 40),
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidget,
                    child: Obx(
                          () => CustomDropdown(
                        dropdownPadding: const EdgeInsets.only(left: 10),
                        icon:  const Icon(
                          Icons.arrow_drop_down,
                          color: Palette.kColorWhite,
                        ),
                        dropdownDecoration: const BoxDecoration(
                            color: Palette.backgroundBgFirst),
                        iconSize: 30,
                        hint: 'Select',
                        dropdownItems: loginController.typeList,
                        value: loginController.selectTypeValue.value,
                        onChanged: (value) {
                          loginController.selectTypeValue.value =
                          value!;
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    color: Palette.kColorWhite,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  email,
                  const SizedBox(
                    height: 10,
                  ),
                  password,
                  const SizedBox(
                    height: 40,
                  ),
                  loginButton(screenWidget),
                  const SizedBox(
                    height: 40,
                  ),
                  skipText,
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget get enterMobileNUmberText {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 20,
          child: Text(
            "MOBILE NUMBER",
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
        style: TextStyles.headingTexStyle(
          color: Palette.kColorWhite,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Montserrat',
        ),
        textAlign: TextAlign.left,
        controller: loginController.userNameController,
        decoration:  InputDecoration(
            hintText: "Enter your email",
            labelText: "Email",
            hintStyle: const TextStyle(color: Palette.colorWhite),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .50),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .5),
            ),
            labelStyle: TextStyles.headingTexStyle(

              color: Palette.colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            )),
      ),
    );
  }

  Widget get password {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: TextField(
        obscureText: _isHidden,
        cursorColor: Colors.white,
        style: TextStyles.headingTexStyle(
          color: Palette.kColorWhite,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          fontFamily: 'Montserrat',
        ),
        textAlign: TextAlign.left,
        controller: loginController.passwordController,
        decoration:  InputDecoration(
            suffixIcon: InkWell(onTap: (){_togglePasswordView;},child:_isHidden?const Icon( Icons.visibility):const Icon( Icons.visibility)),
            hintText: "Enter your password",
            labelText: "Password",
            hintStyle: const TextStyle(color: Palette.coloPageBg),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .50),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: .5),
            ),
            labelStyle: TextStyles.headingTexStyle(

              color: Palette.coloPageBg,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            )),
      ),
    );
  }

  Widget get companyLogo {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.asset("assets/png/logo.png"),
    );
  }

  Widget loginButton(double screenWidget) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "LOGIN",
                () async => {
              //DashboardPage.start()
              loginController.callLoginApi()
            },
            borderRadius: 10.0),
      ),
    );
  }

  Widget get skipText {
    return InkWell(
      onTap: () {
        Get.delete<ForgotOtpController>();
        ForgotPasswordPage.start();
        // DashboardPage.start();
      },
      child: SizedBox(
        height: 20,
        child: Text(
          "Forgot password?",
          style: TextStyles.headingTexStyle(
            color: Palette.kColorWhite,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
    );
  }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
