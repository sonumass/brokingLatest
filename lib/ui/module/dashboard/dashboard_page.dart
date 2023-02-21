import 'package:broking/theme/my_theme.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';

class DashboardPage extends AppPageWithAppBar {
  static const String routeName = "/DashboardPage";

  DashboardPage({Key? key}) : super(key: key);

  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.themeColor),
        foregroundColor: Palette.appColor,
        primary: true,
        backgroundColor: Palette.appColor,
        title: const Text('Broking'),
      ),
      drawer: Drawer(
        backgroundColor: MyColors.themeColor,
        elevation: 10.0,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: Palette.appColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                    radius: 40.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Tom Cruise',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'tomcruise@gmail.com',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),
            //Here you place your menu items
            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Palette.kColorWhite,
              ),
              title: const Text('Profile',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                // Here you can give your route to navigate
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_add,
                color: Palette.kColorWhite,
              ),
              title: const Text('Prospects',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                // Here you can give your route to navigate
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),
            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Palette.kColorWhite,
              ),
              title: const Text('Renewable',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),

            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Palette.kColorWhite,
              ),
              title: const Text('Meeting',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),

            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Palette.kColorWhite,
              ),
              title: const Text('Reminder',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),

            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Palette.kColorWhite,
              ),
              title: const Text('References',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),

            ListTile(
              leading: const Icon(
                Icons.account_box,
                color: Palette.kColorWhite,
              ),
              title: const Text('Dashboard',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
              },
            ),
            const Divider(
              height: 3.0,
              color: Palette.kColorWhite,
            ),
          ],
        ),
      ),
      body: bodyView,
    );
  }

  Widget get bodyView {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                cardWidget((){},"sonu","My Prospects"),
                cardWidget((){},"sonu","My Renewable"),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                cardWidget((){},"sonu","My Meetings"),
                cardWidget((){},"sonu","My Reminders"),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                cardWidget((){},"sonu","My References"),
                cardWidget((){},"sonu","My Dashboard"),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget cardWidget(
    VoidCallback onPress,
    String assetName,
    String cardLabel,
  ) {
    return InkWell(
      onTap: onPress,
      child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    color: MyColors.themeColor,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(Icons.account_box,color: Palette.kColorWhite,),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Text(cardLabel,
                    maxLines: 2,
                    style: TextStyles.headingTexStyle(
                        color: MyColors.themeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'))
              ],
            ),
          ),

    );
  }
}
