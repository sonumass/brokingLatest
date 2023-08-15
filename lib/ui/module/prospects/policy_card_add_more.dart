import 'package:broking/utils/common_util.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controllers/prospects/contact_add_controller.dart';
import '../../../model/ddd/login_type_data.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/custom_drop_down3.dart';
import '../../commonWidget/intpuformater.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';

class PolicyAddMorePage extends AppPageWithAppBar {
  static const String routeName = "/PolicyAddMorePage";

  PolicyAddMorePage({super.key});

  static Future<bool?> start<bool>({prospectId}) {
    return navigateTo<bool>(
        currentPageTitle: "Prospects",
        routeName,
        arguments: {"prospectId": prospectId});
  }
  RxList<LoginTypeData> verticalList = [ LoginTypeData(id: "1",type:"Corporate" ),
    LoginTypeData(id: "2",type:"SME" ),
    LoginTypeData(id: "3",type:"Retail" ),
    LoginTypeData(id: "4",type:"Government" ),
    LoginTypeData(id: "5",type:"Aviation" ),].obs;
  late final Rx<LoginTypeData>  verticalListValue =verticalList.first.obs;
  final controller = Get.put(ContactAddController());
  final renewableDateController = TextEditingController();
  final suminsuredController = TextEditingController();
  final premiumController = TextEditingController();
  final remarkController = TextEditingController();
  final docUploadController = TextEditingController();
  final policyNameController = TextEditingController();
  final uploadDocController = TextEditingController();
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
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }

  Widget get formData {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: const BoxDecoration(
            color: MyColors.kColorWhite,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
           /* labelAndTextField("Policy Type", "", policyNameController, "text",
                250, TextCapitalization.words, TextInputType.text),*/
            policyTypeDropDown("Policy Type"),
            dateTextField("Renewal Date", renewableDateController,DateTime.now(),DateTime(2024)),
            labelAndTextField("Sum insured ", "", suminsuredController,
                "number", 12, TextCapitalization.words, TextInputType.number,[FilteringTextInputFormatter.digitsOnly],),
            labelAndTextField("Premium", "", premiumController, "number", 12,
                TextCapitalization.words, TextInputType.number,[FilteringTextInputFormatter.digitsOnly],),
            labelAndTextField("Remark", "", remarkController, "text", 250,
                TextCapitalization.sentences, TextInputType.text, [FilteringTextInputFormatter.allow(RegExp("a-za-z0-9\u0020-\u007e-\u0024-\u00a9")),]),
            uploadDoc(
              "Upload Doc",
              "Click here",
            ),
            Obx(() => controller.platformFile.isNotEmpty
                ? Column(
                    children: platformFile,
                  )
                : const SizedBox.shrink()),
            savaButton()
          ],
        ),
      ),
    );
  }
  Widget  policyTypeDropDown(String label){
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () => CustomDropdown3(
                icon: const Icon(Icons.arrow_drop_down),
                dropdownDecoration: const BoxDecoration(borderRadius: BorderRadius.all(
                    Radius.circular(20.0) //                 <--- border radius here
                ),),
                iconSize: 30,
                hint: 'Select Vertical',
                dropdownItems: verticalList,
                value: verticalListValue.value,
                onChanged: (value) {
                  verticalListValue.value = value!;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
  List<Widget> get platformFile {
    List<Widget> list = [];
    for (var element in controller.platformFile) {
      list.add(Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SizedBox(
            width: screenWidget,
            child: Text(
              element.name,
              textAlign: TextAlign.right,
              style: TextStyles.headingTexStyle(
                color: Palette.appColor,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
              ),
            ),
          )));
    }
    return list;
  }

  Widget labelAndTextField(
      String label,
      String text,
      TextEditingController controller,
      String type,
      int maxLength,
      TextCapitalization textCapitalization,
      TextInputType textInputType,List<TextInputFormatter>? inputFormatters) {
    controller.text = text;
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
              controller: controller,
              maxLines: 1,
              maxLength: maxLength,
              obscureText: false,
              keyboardType: textInputType,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
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

  Widget uploadDoc(String label, String text) {
    uploadDocController.text = text;
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
              controller: uploadDocController,
              textAlign: TextAlign.center,
              maxLines: 1,
              showCursor: false,
              cursorColor: Palette.kColorWhite,
              onTap: () async {
                controller.selectedFile();
              },
              keyboardType: TextInputType.none,
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
          controller.selectDate(dateController,firstDateTime,lastDateTime);
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
  Widget verticalDropDown(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.textHeadingColor,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 50,
            child: Obx(
              () => CustomDropdownButton2(
                icon: const Icon(Icons.arrow_drop_down),
                dropdownDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                ),
                iconSize: 30,
                hint: 'Select Item',
                dropdownItems: items,
                value: selectedValue.value,
                onChanged: (value) {
                  selectedValue.value = value!;
                },
              ),
            ),
          )
        ],
      ),
    );
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

  Widget savaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn(
          "Add Policy",
          () {
            if (arguments["prospectId"] != null) {
              Navigator.of(Get.context!).pop();
            } else {
              if (renewableDateController.text.isEmpty) {
                Common.showToast("Please enter Renewal date");
                return;
              }

              controller.addPolicy(
                  renewalDate: renewableDateController.text,
                  suminsured: suminsuredController.text,
                  premium: premiumController.text,
                  policyName: verticalListValue.value.id,
                  uploadDoc: controller.base64Data,
                  remarks: remarkController.text,
                  fileExt: controller.fileExt);
              Navigator.of(Get.context!).pop();
            }
          },
          borderRadius: 10.0,
          color: Palette.backgroundBgFirst,
          textColor: Palette.kColorWhite,
        ),
      ),
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
                child: Text("Policy Details",
                    style: TextStyles.headingTexStyle(
                        color: Palette.textOnThemeBg,
                        fontFamily: "assets/font/Oswald-Bold.ttf")),
              )
            ],
          ),
        ],
      ),
    );
  }
}
