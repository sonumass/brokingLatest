import 'dart:ui';
import 'package:broking/ui/dialog/loader.dart';
import 'package:broking/ui/module/prospects/contact_card_add_more.dart';
import 'package:broking/ui/module/prospects/policy_card_add_more.dart';
import 'package:broking/ui/module/prospects/prodpect_deatil_card_add_more.dart';
import 'package:broking/ui/module/prospects/prospects_preview_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/location_controller.dart';
import '../../../controllers/prospects/contact_add_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';
class ProspectsCreatePage extends AppPageWithAppBar {
  static const String routeName = "/ProspectsCreatePage";
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final items = <String>[];
  ProspectsCreatePage({super.key});
  final location = Get.put(LocationController());
  final controller = Get.put(ContactAddController());
  static Future<bool?> start<bool>() {
    return navigateTo<bool>(
      currentPageTitle: "Prospects",
      routeName,
    );
  }
  @override
  double? get toolbarHeight => 0;
  @override
  Widget get body {
    controller.callProspectDataApi();
    return Obx(() => controller.isLoader.value?const Loader():Scaffold(
        body: SingleChildScrollView(
          child: Container(height:screenHeight,width:screenWidget,decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/png/background.png"),
              fit: BoxFit.cover,
            ),
          ),child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              appBarWidget,
              myText,
              prospectsDetail(),
              contactDetail(),
              policyDetail(),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [previewButton(),uploadButton()],)
            ],
          ),),
        )));
  }
  Widget get appBarWidget{
    return Column(children: [const PreferredSize(
      preferredSize: Size.fromHeight(50.0),child: SizedBox(height: 50,),),Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: SvgPicture.asset(width:25,height: 25,'assets/png/back_bar.svg'),
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
      )],)],);

  }
  Widget get myText {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
          child: Text(
            "Add",
            style: TextStyles.headingTexStyle(
              color: Palette.colorWhite,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 0, bottom: 10),
          child: Text(
            "Prospect",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorWhite,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        )
      ],
    );
  }
  Widget prospectsDetail() {
    return InkWell(
      onTap: () {
        CreateAddProspectPage.start(premiumPotential:controller.premiumPotential ,policyType: controller.policyType,vertical: controller.vertical,industryType:controller.industryType);
      },
      child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          color: Palette.kColorWhite,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 1, color: MyColors.themeColor)),
          child: Column(
            children: [cardHeader("Prospect Detail")],
          )),
    );
  }

  Widget contactDetail() {
    return InkWell(
      onTap: () {
        ContactAddMorePage.start();
      },
      child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          color: Palette.kColorWhite,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 1, color: MyColors.themeColor)),
          child: Column(
            children: [cardHeader("Contact Detail")],
          )),
    );
  }

  Widget policyDetail() {
    return InkWell(
      onTap: () {
        PolicyAddMorePage.start();
      },
      child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(10),
          color: Palette.kColorWhite,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 1, color: MyColors.themeColor)),
          child: Column(
            children: [cardHeader("Policy Detail")],
          )),
    );
  }

  Widget cardHeader(String headerTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.account_circle_sharp,
                color: Palette.textHeadingColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 10),
              child: Text(headerTitle,
                  style: TextStyles.headingTexStyle(
                      color: Palette.textHeadingColor,
                      fontFamily: "assets/font/Oswald-Bold.ttf")),
            )
          ],
        ),
      ],
    );
  }

  Widget previewButton() {
    return SizedBox(height: 60,width: screenWidget/2.2,child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 0, top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn("Preview", () {
          //loginController.callLoginApi(type: "5")
          ProspectsPreviewDetailPage.start();
        }, borderRadius: 10.0),
      ),
    ),);
  }
  Widget uploadButton() {
    return SizedBox(height: 60,width: screenWidget/2.2,child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 10, top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn("Add Prospect", () {
          //loginController.callLoginApi(type: "5")
          //ProspectsPreviewDetailPage.start();
          controller.createProspectApi();
        }, borderRadius: 10.0),
      ),
    ),);
  }
}
