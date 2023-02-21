import 'package:broking/ui/module/dashboard/dashboard_page.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controllers/login/login_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import 'forgot_password_page.dart';

class LoginPage extends AppPageWithAppBar {
  static const String routeName = "/login";
  final loginController = Get.put(LoginController());
  LoginPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }

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

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Scaffold(
        backgroundColor: Palette.kColorWhite,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight / 3,
                child: Center(child: companyLogo,),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 3,
                  child: Padding(padding: const EdgeInsets.all(10),child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: screenWidget,
                        child: Obx(
                              () => CustomDropdownButton2(
                            icon: const Icon(Icons.arrow_drop_down),
                            dropdownDecoration: const BoxDecoration(borderRadius: BorderRadius.all(
                                Radius.circular(20.0) //                 <--- border radius here
                            ),),
                            iconSize: 30,
                            hint: 'Select Item',
                            dropdownItems: items,
                            value: selectedValue.value,
                            onChanged: (value) {
                              selectedValue.value = value!;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      email,
                      const SizedBox(height: 10,),
                      password,
                      const SizedBox(height: 10,),
                      Align(alignment: Alignment.centerRight,child: skipText,),
                      const SizedBox(height: 10,),
                      loginButton(screenWidget),

                    ],
                  ),),
                ),
              )
            ],
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
      controller: loginController.userNameController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.emailAddress,
      decoration:  InputDecoration(
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
Widget get password {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: TextField(
      controller: loginController.passwordController,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.text,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      decoration:  InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        prefixIcon: const Icon(Icons.lock),
        hintText: 'Enter you password ',
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



Widget  loginButton(double screenWidget) {
  return Padding(
    padding: const EdgeInsets.only(left: 0, right: 0),
    child: SizedBox(
      width: screenWidget,
      height: 45,
      child: PrimaryElevatedBtn(
          "Login",
              () async => {
            DashboardPage.start()
                //loginController.callLoginApi(type: "5")
          },
          borderRadius: 10.0),
    ),
  );
}

Widget get skipText {
  return InkWell(
    onTap: () {
      ForgotPasswordPage.start();
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
