import 'package:broking/ui/dialog/loader.dart';
import 'package:broking/ui/module/prospects/widget/prospects__list_card.dart';
import 'package:broking/ui/module/reminder/widget/reminder_list_card.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/prospect_list_controller.dart';
import '../../../controllers/reminder/reminder_list_controller.dart';
import '../../../controllers/renewable/prospect_list_controller.dart';
import '../../../services/navigator.dart';
import '../../base/page.dart';
import '../../commonWidget/text_style.dart';

class ReminderPage extends AppPageWithAppBar {
  static const String routeName = "/ReminderPage";
  final controller = Get.put(ReminderListController());
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final items = <String>[];
  static Future<bool?> start<bool>() {
    return navigateTo<bool>(currentPageTitle: "My Reminder", routeName);
  }

  ReminderPage({super.key});

  @override // TODO: implement appBar
  @override
  List<Widget>? get action => [
        InkWell(
          onTap: () {
            // ProspectsCreatePage.start();
          },
          child: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
            child: Stack(
              children: const [
                Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: Palette.kColorWhite,
                    )),
              ],
            ),
          ),
        )
      ];

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Obx(() => controller.isLoader.value
        ? const Loader()
        : Scaffold(
            backgroundColor: Palette.backgroundBg,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/png/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: appBarWidget,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 30,),
                  ),

                  SliverToBoxAdapter(
                    child: myText,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 30,),
                  ),
                  if (controller.reminderCount !=null)
                     SliverToBoxAdapter(
                      child: cardColumn,
                    ),
                ],
              ),
            )));
  }

  Widget get appBarWidget {
    return Column(
      children: [
        const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: SizedBox(
            height: 50,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset(
                    width: 25, height: 25, 'assets/png/back_bar.svg'),
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

  Widget get myText {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 20, bottom: 8),
              child: Text(
                "My",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 0, bottom: 10),
              child: Text(
                "Reminder",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            )
          ],
        ),
        Padding(padding: const EdgeInsets.only(right: 10),child: SvgPicture.asset("assets/png/ic_avtar_icon.svg"),)

      ],
    );
  }
Widget get cardColumn{
    return Column(children: [
      ReminderListCard(cardName: "Upcoming Meeting Reminder",count: controller.reminderCount?.upcommingMeeting ??"",),
      ReminderListCard(cardName: "Renewal Reminder",count: controller.reminderCount?.upcommingRenewals ??"",),
      ReminderListCard(cardName: "Birthday Reminder",count: controller.reminderCount?.upcommingBirthday ??"",),
      ReminderListCard(cardName: "Aniversary Reminder",count: controller.reminderCount?.upcommingAniversay ??"",),
    ],);
}
}
