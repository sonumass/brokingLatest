import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/contact_add_controller.dart';
import '../../../controllers/prospects/contact_controller.dart';
import '../../../controllers/prospects/prospect_list_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/common_util.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/intpuformater.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';

class ContactAddMorePage extends AppPageWithAppBar {
  static const String routeName = "/ContactAddMorePage";

  ContactAddMorePage({super.key});

  static Future<bool?> start<bool>({prospectId}) {
    return navigateTo<bool>(
        currentPageTitle: "Prospects",
        routeName,
        arguments: {"prospectId": prospectId});
  }

  final listController = Get.find<ProspectListController>();
  final controller = Get.put(ContactAddController());
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final locationController = TextEditingController();
  final emailIdController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();
  final birthdayController = TextEditingController();
  final aniversaryController = TextEditingController();
  final decesionmakerController = TextEditingController();
  final controllerAddMore = Get.put(ContactController());
  RxBool decisionMaker = true.obs;

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: screenHeight,
        width: screenWidget,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [appBarWidget, card],
        ),
      ),
    ));
  }

  Widget get card {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        color: Palette.kColorWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 1, color: MyColors.themeColor)),
        child: Column(
          children: [
            cardHeader,
            formData,
            savaButton(),
            const SizedBox(
              height: 20,
            )
          ],
        ));
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

  Widget get formData {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          labelAndTextField(
            "Name",
            "",
            nameController,
            "text",
            250,
              TextCapitalization.words,
              TextInputType.text,
              [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
          ),
          labelAndTextField(
            "Designation",
            "",
            designationController,
            "text",
              250,
              TextCapitalization.words,
              TextInputType.text,
              [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
          ),
          labelAndTextField(
            "Prospects Address",
            "",
            locationController,
            "text",
              250,
              TextCapitalization.sentences,
              TextInputType.text,
              [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
          ),
          decisionMakerView,
          emailField(
            "Email",
            "",
            emailIdController,
            "text",
              250,
              TextCapitalization.sentences,
              TextInputType.emailAddress,
          ),
          labelAndTextField(
            "Phone 1",
            "",
            phone1Controller,
            "number",
              12,
              TextCapitalization.words,
              TextInputType.number,
            [FilteringTextInputFormatter.digitsOnly],
          ),
          labelAndTextField(
            "Phone2",
            "",
            phone2Controller,
            "number",
              12,
              TextCapitalization.words,
              TextInputType.number,
            [FilteringTextInputFormatter.digitsOnly],
          ),
          dateTextField("Birthday", birthdayController,DateTime(1900),DateTime.now()),
          dateTextField("Anniversary", aniversaryController,DateTime(1900),DateTime.now()),
        ],
      ),
    );
  }

  Widget get decisionMakerView {
    return Row(
      children: [
        Text(
          "Decision Maker",
          textAlign: TextAlign.center,
          style: TextStyles.headingTexStyle(
            color: Palette.textHeadingColor,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(
          width: 35,
        ),
        Obx(() => Checkbox(
              checkColor: Palette.kColorWhite,
              activeColor: Palette.appBar,
              value: decisionMaker.value,
              shape: const CircleBorder(),
              onChanged: (value) {
                decisionMaker.value = value!;
              },
            ))
      ],
    );
  }

  Widget get cardHeader {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.cardBg,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.account_circle_sharp,
                  color: Palette.kColorWhite,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 10),
                child: Text("Contact Details",
                    style: TextStyles.headingTexStyle(
                        color: Palette.textOnThemeBg,
                        fontFamily: "assets/font/Oswald-Bold.ttf")),
              )
            ],
          ),
        ],
      ),
    );
    /*return InkWell(
      onTap: () {

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.account_circle_sharp,
                  color: Palette.kColorWhite,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 10),
                child: Text("Contact Details",
                    style: TextStyles.headingTexStyle(
                        color: Palette.textOnThemeBg,
                        fontFamily: "assets/font/Oswald-Bold.ttf")),
              )
            ],
          ),

        ],
      ),
    );*/
  }

  Widget labelAndTextField(String label, String text,
      TextEditingController textController, String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType,List<TextInputFormatter>? inputFormatters)  {
    textController.text = text;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.textHeadingColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: TextFormField(
              controller: textController,
              maxLines: 1,
              maxLength: maxLength,
              inputFormatters: inputFormatters,
              textCapitalization:textCapitalization,
              obscureText: false,
              onChanged: (value) {},
              keyboardType:textInputType,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 5),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.1, color: MyColors.kColorExtraLightGrey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.1, color: MyColors.kColorExtraLightGrey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                counterText: '',
                fillColor: const Color(0xfff3f3f4),
                filled: true,
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget emailField(String label, String text,
      TextEditingController textController, String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType)  {
    textController.text = text;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.textHeadingColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: TextFormField(
              controller: textController,
              maxLines: 1,
              maxLength: maxLength,
              textCapitalization:textCapitalization,
              obscureText: false,
              onChanged: (value) {},
              keyboardType:textInputType,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 5),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.1, color: MyColors.kColorExtraLightGrey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1.1, color: MyColors.kColorExtraLightGrey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                counterText: '',
                fillColor: const Color(0xfff3f3f4),
                filled: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dateTextField(String label, TextEditingController dateController,DateTime firstDateTime,DateTime lastDateTime) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.textHeadingColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: dateWidget(dateController,firstDateTime,lastDateTime),
          )
        ],
      ),
    );
  }

  Widget dateWidget(TextEditingController dateController,DateTime firstDateTime,DateTime lastDateTime) {
    return TextFormField(
        controller: dateController,
        inputFormatters: <TextInputFormatter>[UpperCaseTextFormatter()],
        maxLines: 1,
        keyboardType: TextInputType.none,
        showCursor: false,
        obscureText: false,
        onTap: () {
          controller.selectDate(dateController, firstDateTime, lastDateTime);
        },
        decoration: InputDecoration(
          hintText: "dd-mm-yyyy",
          suffixIcon: const Icon(
            Icons.calendar_month,
            color: Palette.prospectCardTextColor,
          ),
          contentPadding:
              const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1.1, color: MyColors.kColorExtraLightGrey),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1.1, color: MyColors.kColorExtraLightGrey),
            borderRadius: BorderRadius.circular(20.0),
          ),
          counterText: '',
          fillColor: const Color(0xfff3f3f4),
          filled: true,
        ));
  }
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  Widget savaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: SizedBox(
        width: screenWidget / 1.3,
        height: 45,
        child: PrimaryElevatedBtn(
          "Add Contact",
          () {
            if (arguments["prospectId"] != null) {
              Navigator.of(Get.context!).pop();
              // listController.contactInputDataList.add(ContactItemInput(contactpersonid: "", prospectid: arguments["prospectId"], personname: nameController.text, designation: designationController.text, personlocation: locationController.text, email: emailIdController.text, phone: phone1Controller.text, decesionmaker: decesionmakerController.text, phone2: phone2Controller.text, birthday: birthdayController.text, anniversary: aniversaryController.text));
              //controllerAddMore.editProspect();
            } else {
              if (nameController.text.isEmpty) {
                Common.showToast("Please enter name");
                return;
              }
              if (emailIdController.text.isEmpty) {
                Common.showToast("Please enter email");
                return;
              }
              if (!isEmail(emailIdController.text)) {
                Common.showToast("Please enter valid email");
                return;
              }
              if (phone1Controller.text.isEmpty &&
                  phone2Controller.text.isEmpty) {
                Common.showToast("Please enter at least one phone");
                return;
              }
              if (phone1Controller.text.isNotEmpty &&
                  phone1Controller.text.length<10) {
                Common.showToast("Please enter valid phone1");
                return;
              }
              if (phone2Controller.text.isNotEmpty &&
                  phone2Controller.text.length<10) {
                Common.showToast("Please enter valid phone2");
                return;
              }

              Navigator.of(Get.context!).pop();
              controller.addContact(
                  name: nameController.text,
                  email: emailIdController.text,
                  designation: designationController.text,
                  location: locationController.text,
                  decisionMaker: decisionMaker.value ? "Yes" : "No",
                  phone1: phone1Controller.text,
                  phone2: phone2Controller.text,
                  birthday: birthdayController.text,
                  anniversary: aniversaryController.text);
            }
            //debugPrint(controller.contactInputDataList.toList().toString())
          },
          borderRadius: 10.0,
          color: Palette.backgroundBgFirst,
          textColor: Palette.kColorWhite,
        ),
      ),
    );
  }
}
