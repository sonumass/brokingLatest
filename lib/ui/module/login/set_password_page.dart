import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../base/page.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonwidget/text_style.dart';
import '../dashboard/dashboard_page.dart';

class ChangePasswordPage extends AppPageWithAppBar {
  static const String routeName = "/ChangePasswordPage";

  ChangePasswordPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }


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
                        newPassword,
                        confirmPassword,
                        const SizedBox(
                          height: 10,
                        ),
                        loginButton()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }



  Widget get newPassword {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
      child: TextField(
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        obscureText: false,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        decoration: InputDecoration(
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

  Widget get confirmPassword {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
      child: TextField(
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          prefixIcon: const Icon(Icons.lock),
          hintText: 'Enter you confirm password ',
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
  Widget  loginButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget,
        height: 45,
        child: PrimaryElevatedBtn(
            "Set Password",
                () async => {
                  DashboardPage.start()
            },
            borderRadius: 10.0),
      ),
    );
  }
}
