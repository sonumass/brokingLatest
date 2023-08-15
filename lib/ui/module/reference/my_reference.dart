import 'package:broking/ui/dialog/loader.dart';
import 'package:broking/utils/common_util.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/reference/my_reference_controller.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../base/page.dart';
import '../../commonWidget/custom_drop_down3.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';

class ReferencePage extends AppPageWithAppBar {
  static const String routeName = "/ReferencePage";
  final controller = Get.put(ReferenceController());
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final referenceName = TextEditingController();
  final mobileNumber = TextEditingController();
  final emailAddress = TextEditingController();
  final contactPerson = TextEditingController();
  final searchProspect = TextEditingController();
  final premiumPotential = TextEditingController();
  static Future<bool?> start<bool>() {
    return navigateTo<bool>(currentPageTitle: "My Reminder", routeName);
  }

  ReferencePage({super.key});

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
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: myText,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                 // if (controller.reminderCount != null)
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
                "Reference",
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
        /*Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SvgPicture.asset("assets/png/ic_avtar_icon.svg"),
        )*/
      ],
    );
  }

  Widget get cardColumn {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        child: Column(
          children: [
            referenceDetail,
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  lastMeetingDateLabelAndTextField("Referral Name", "",referenceName,"text",[FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]),
                  lastMeetingDateLabelAndTextField("Mobile Number", "",mobileNumber,"number",[FilteringTextInputFormatter.digitsOnly],),
                   emailField(
                    "Email",
                    "",
                    emailAddress,
                    "text",
                    250,
                    TextCapitalization.sentences,
                    TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10,),
                  lastMeetingDateLabelAndTextField("Prospect", "",searchProspect,"text",[FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]),
                  lastMeetingDateLabelAndTextField("Contact Person", "",contactPerson,"text",[FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]),
                  potentialDropDownType("Premium potential"),
                  const SizedBox(height: 10,),
                  policyDropDownType("Policy"),
                  const SizedBox(height: 20,),
                  saveButton(150),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get referenceDetail {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/png/ic_user.svg"),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Reference Detail",
            style: TextStyles.headingTexStyle(
              color: Palette.kColorBlack,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ),
    );
  }

  Widget lastMeetingDateLabelAndTextField(String text, String label,TextEditingController controller,String type,List<TextInputFormatter>? inputFormatters) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Text(text,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ))),
          labelAndTextField(label, text, controller, type,inputFormatters),

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

  Widget labelAndTextField(
      String text, String hint, TextEditingController controller, String type,List<TextInputFormatter>? inputFormatters) {
    controller.text = text;
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 0, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 1.9,
            height: 40,
            child: Card(
              elevation: 10,
              color: Palette.kColorWhite,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  side: BorderSide(
                      width: .5, color: Palette.prospectCardTextColor)),
              child: TextFormField(
                controller: controller,
                inputFormatters:inputFormatters,
                maxLines: 1,
                maxLength: hint.toLowerCase().contains("mobile")?12:250,
                obscureText: false,
                keyboardType:
                    type == "text" ? TextInputType.text : TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: MyColors.kColorWhite),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: MyColors.kColorWhite),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  counterText: '',
                  fillColor: Palette.kColorWhite,
                  filled: true,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
 /* Widget prospectDropDownType(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Text(label,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ))),
          SizedBox(
              width: screenWidget / 1.9,
              height: 40,
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      width: .25, color: Palette.prospectCardTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                child: searchProspect(),
              )),
        ],
      ),
    );
  }*/
 /* Widget searchProspect(){
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }*/
  Widget policyDropDownType(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Text(label,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ))),
          SizedBox(
              width: screenWidget / 1.9,
              height: 40,
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      width: .25, color: Palette.prospectCardTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                child: Obx(
                      () => CustomDropdown3(
                    borderColor: Colors.grey,
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          10.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select Policy',
                    dropdownItems: controller.policyType,
                    value: controller.policyValue.value,
                    onChanged: (value) {
                      controller.policyValue.value= value!;
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
  Widget potentialDropDownType(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Text(label,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ))),
          SizedBox(
              width: screenWidget / 1.9,
              height: 40,
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      width: .25, color: Palette.prospectCardTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                child: Obx(
                      () => CustomDropdown3(
                    borderColor: Colors.grey,
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          10.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select potential',
                    dropdownItems: controller.premiumPotential,
                    value: controller.premiumPotentialValue.value,
                    onChanged: (value) {
                      controller.premiumPotentialValue.value= value!;
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
  Widget saveButton(double screenWidget) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget,
        height: 40,
        child: PrimaryElevatedBtn(
            "SAVE",
                () {
                  if(referenceName.text.isEmpty){
                    Common.showToast("Please enter reference name");
                  }
              if(emailAddress.text.isEmpty){
                Common.showToast("Please enter email");
              }
              if (!isEmail(emailAddress.text)) {
                Common.showToast("Please enter valid email");
                return;
              }
                  if(contactPerson.text.isEmpty){
                    Common.showToast("Please enter contact person name");
                  }

              controller.sentReference(referenceName.text, mobileNumber.text,emailAddress.text,searchProspect.text,contactPerson.text,controller.premiumPotentialValue.value.id,controller.policyValue.value.id);
            },
            borderRadius: 20.0,color:Palette.appColor,
          textColor:Palette.kColorWhite,),
      ),
    );
  }
}
