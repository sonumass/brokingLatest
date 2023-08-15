import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/module/login/login_page.dart';
import 'package:broking/ui/module/meetings/dashboard_my_meeting_prospect.dart';
import 'package:broking/ui/module/prospects/prospect_list.dart';
import 'package:broking/ui/module/reminder/reminder_list.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../controllers/reminder/alarm_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';
import '../meetings/meeting_list.dart';
import '../meetings/my_meeting_list.dart';
import '../reference/my_reference.dart';
import '../reminder/reminder_list_detail_list.dart';
import 'my_dashboard.dart';

class DashboardPage extends AppPageWithAppBar {
  static const String routeName = "/DashboardPage";
  DashboardPage({Key? key}) : super(key: key);
  static Future<bool?> start<bool>() {
    return navigateTo<bool>(routeName);
  }

  final appPreferences = Get.find<AppPreferences>();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  final controller =Get.put(AlarmController());

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    _getGeoLocationPosition();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.backgroundBg,

      // appBar: AppBar(
      //   backgroundColor: Palette.appBar,
      //   elevation: 0.0,
      //   leading: Builder(builder: (BuildContext context) {
      //     return GestureDetector(
      //       onTap: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //       child: Padding(
      //         padding: const EdgeInsets.all(17),
      //         child: SvgPicture.asset('assets/png/icon_hamburger.svg'),
      //       ),
      //     );
      //   }),
      //   title: Center(
      //     child: SizedBox(
      //       width: 50,
      //       height: 50,
      //       child: Image.asset("assets/png/ic_crown.png",),
      //     ),
      //   ),
      //   actions: [
      //     InkWell(
      //       onTap: () {},
      //       child: Padding(
      //         padding:
      //             const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
      //         child: Stack(
      //           children: [
      //             SizedBox(
      //               width: 40,
      //               height: 40,
      //               child: Image.asset("assets/png/ic_notification.png"),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      drawer: Drawer(
        width: screenWidget / 1.55,
        backgroundColor: Palette.appBar,
        elevation: 10.0,
        child: Container( decoration: const BoxDecoration(
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
        ),child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SvgPicture.asset(
                      width: 80, height: 80, 'assets/png/actar.svg'),

                  // CircleAvatar(
                  //   backgroundImage: NetworkImage(appPreferences.userImage),
                  //   radius: 40.0,
                  // ),

                  Text(
                    appPreferences.userName,
                    style: TextStyles.headingTexStyle(
                      color: Palette.kColorWhite,
                      fontSize: 22,
                      height: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  Text(
                    appPreferences.email,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //Here you place your menu items
            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_profile.svg'),
              title: const Text('Profile',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                // Here you can give your route to navigate
              },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_prospect_d.svg'),
              title: const Text('Prospects',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                ProspectsListPage.start();
                // Here you can give your route to navigate
              },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_renewable_d.svg'),
              title: const Text('Renewals',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                ReminderDetailListPage.start("Renewal Reminder", "","Renewal Reminder");
              },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_meeting_d.svg'),
              title: const Text('Meeting',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                MyMeetingListPage.start();

              },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 18, width: 18, 'assets/png/ic_reminder_d.svg'),
              title: const Text('Reminder',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                ReminderPage.start();
              },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_reference_d.svg'),
              title: const Text('References',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                ReferencePage.start();
                },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_dashboard_d.svg'),
              title: const Text('Dashboard',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                MyHomeDashboardPage.start();
                },
            ),

            ListTile(
              leading: SvgPicture.asset(
                  height: 20, width: 20, 'assets/png/ic_logout.svg'),
              title: const Text('LogOut',
                  style: TextStyle(fontSize: 18, color: Palette.kColorWhite)),
              onTap: () {
                Get.back();
                appPreferences.saveLoggedIn(false);
                LoginPage.start();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Powered By',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: MyColors.kColorWhite,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  width: 8,
                ),
                Image.asset(height: 72, width: 72, 'assets/png/ic_power.png'),
              ],
            )
            // ,
          ],
        ),),
      ),
      body: bodyView,
    );
  }

  Widget get appBarWidget {
    return Column(
      children: [
        const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: SizedBox(
            height: 40,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset('assets/png/icon_hamburger.svg'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 50,
                child: SvgPicture.network("https://3ditec.co.in/broking/assets/images/crownlogo.svg"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 15, top: 8, bottom: 8),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset('assets/png/ic_notification.svg'),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget get icon {
    return SvgPicture.asset('assets/png/ic_prospect.svg');
  }

  Widget get bodyView {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.only(left: 0, right: 0),
          width: screenWidget,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/png/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              appBarWidget,
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "Hello,",
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  appPreferences.userName,
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorWhite,
                    fontSize: 22,
                    height: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardWidget(() {
                    ProspectsListPage.start();
                  }, "sonu", "My Prospects"),
                  cardRenewable(() {ReminderDetailListPage.start("Renewal Reminder", "","Renewal Reminder");}, "sonu", "My Renewals"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardMeeting(() {MyMeetingProspectList.start();}, "sonu", "My Meetings"),
                  cardReminder(() {
                    ReminderPage.start();
                  }, "sonu", "My Reminders"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardReference(() {ReferencePage.start();}, "sonu", "My References"),
                  cardDashboard(() {MyHomeDashboardPage.start();}, "sonu", "My Dashboard"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardWidget(
    VoidCallback onPress,
    String assetIcon,
    String cardLabel,
  ) {
    return InkWell(
        onTap: onPress,
        child: SizedBox(
          height: screenWidget / 2.3,
          width: screenWidget / 2.3,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/ic_card.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        height: 50, width: 50, 'assets/png/ic_prospect.svg'),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(cardLabel,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                            color: MyColors.kColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget cardRenewable(
    VoidCallback onPress,
    String assetIcon,
    String cardLabel,
  ) {
    return InkWell(
        onTap: onPress,
        child: SizedBox(
          height: screenWidget / 2.3,
          width: screenWidget / 2.3,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/ic_card.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        height: 50, width: 50, 'assets/png/renewable.svg'),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(cardLabel,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyles.headingTexStyle(
                            color: MyColors.kColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget cardMeeting(
    VoidCallback onPress,
    String assetIcon,
    String cardLabel,
  ) {
    return InkWell(
        onTap: onPress,
        child: SizedBox(
          height: screenWidget / 2.3,
          width: screenWidget / 2.3,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/ic_card.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        height: 50, width: 50, 'assets/png/ic_meeting.svg'),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(cardLabel,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                            color: MyColors.kColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget cardReminder(
    VoidCallback onPress,
    String assetIcon,
    String cardLabel,
  ) {
    return InkWell(
        onTap: onPress,
        child: SizedBox(
          height: screenWidget / 2.3,
          width: screenWidget / 2.3,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/ic_card.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        height: 50, width: 50, 'assets/png/reminder.svg'),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(cardLabel,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                            color: MyColors.kColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget cardReference(
    VoidCallback onPress,
    String assetIcon,
    String cardLabel,
  ) {
    return InkWell(
        onTap: onPress,
        child: SizedBox(
          height: screenWidget / 2.3,
          width: screenWidget / 2.3,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/ic_card.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                        height: 50, width: 50, 'assets/png/reference.svg'),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(cardLabel,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                            color: MyColors.kColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget cardDashboard(
    VoidCallback onPress,
    String assetIcon,
    String cardLabel,
  ) {
    return InkWell(
        onTap: onPress,
        child: SizedBox(
          height: screenWidget / 2.3,
          width: screenWidget / 2.3,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/png/ic_card.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/png/mydashboard.svg'),
                    const SizedBox(
                      height: 31,
                    ),
                    Text(cardLabel,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyles.headingTexStyle(
                            color: MyColors.kColorBlack,
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Montserrat'))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

/*Widget get rr{
    return
}*/
  Future<Position> _getGeoLocationPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception('Error');
    }
    return await Geolocator.getCurrentPosition();
  }
}
