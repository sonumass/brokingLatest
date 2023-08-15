import 'package:broking/controllers/reminder/alarm_controller.dart';
import 'package:broking/ui/module/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../services/navigator.dart';
import '../../theme/my_theme.dart';
import '../../utils/palette.dart';
import '../commonWidget/text_style.dart';
import '../module/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  static Future<bool?> start<bool>(String currentPageTitle) {
    return navigateOffAll<bool>(routeName, currentPageTitle: currentPageTitle);
  }

  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final appPreferences = Get.find<AppPreferences>();
  //final controller = Get.put(SplashController());
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

      setState(() {
        if(appPreferences.isLoggedIn){
          DashboardPage.start();
        }else{
          LoginPage.start();
        }

        // Here you can write your code for open new view
      });

    });

    /*controller.callForceUpdateApi().then((value) {
      if (value) {
        if (appPreferences.isLoggedIn) {
          controller.callUserDashboardCardCall("Cart");
          //Home.start();
          return;
        }
       // LoginPage.start();
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kColorWhite,
      body: Container(
        decoration:  const BoxDecoration(
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
        ),child: SizedBox(
        height: double.infinity,
        width: double.maxFinite,
        child: Center(
          child: Image.asset(
            "assets/png/app_logo.png",
            width: 100,
            height: 100,
          ),
        ),
      ),),
    );
  }

  showAlertDialog() {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Update"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Please update app!"),
      content: Text(
        "This is my message.",
        style: TextStyles.headingTexStyle(color: Colors.black),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
