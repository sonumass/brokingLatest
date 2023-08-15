import 'package:broking/controllers/location_controller.dart';
import 'package:broking/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controllers/prospects/contact_add_controller.dart';
import '../../../model/ddd/city_data.dart';
import '../../../model/ddd/login_type_data.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../base/page.dart';
import '../../commonWidget/custom_drop_down3.dart';
import '../../commonWidget/custom_drop_down5.dart';
import '../../commonWidget/custom_drop_down_state.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';

class CreateAddProspectPage extends AppPageWithAppBar {
  static const String routeName = "/AddProspectPage";

  CreateAddProspectPage({super.key});
  final location = Get.find<LocationController>();
  static Future<bool?> start<bool>(
      {prospectId, premiumPotential, industryType, vertical, policyType}) {
    return navigateTo<bool>(
        currentPageTitle: "Prospects",
        routeName,
        arguments: {
          "prospectId": prospectId,
          "premiumPotential": premiumPotential,
          "industryType": industryType,
          "vertical": vertical,
          "policyType": policyType
        });
  }

  List<LoginTypeData> premiumPotential = [];
  RxList<CityData> cityList = <CityData>[].obs;
  late final Rx<CityData> cityValue = cityList.first.obs;
  List<LoginTypeData> industryType = [];
  List<LoginTypeData> vertical = [];
  List<LoginTypeData> policyType = [];
  final state = "".obs;
  final city = "".obs;
  final country = "".obs;
  final controller = Get.find<ContactAddController>();
  final nameController = TextEditingController();
  final corporateAddressController = TextEditingController();
  final premiumController = TextEditingController();
  final totalMeetingController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final parentController = TextEditingController();
  final turnOverController = TextEditingController();
  final premiumPotentialController = TextEditingController();
  final premiumAchivedController = TextEditingController();
  final writeUPController = TextEditingController();
  final referenceController = TextEditingController();

  @override
  double? get toolbarHeight => 0;

  @override
  Widget get body {
    cityList.add(CityData(id: "0", stateId: "0", cityName: "Select City"));
    premiumPotential = arguments["premiumPotential"];
    industryType = arguments["industryType"];
    vertical = arguments["vertical"];
    policyType = arguments["policyType"];
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
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
            labelAndTextField(
              "Prospect Name",
              controller.prospectDetailInput.prospectName,
              nameController,
              "text",
              250,
                TextCapitalization.words,
              TextInputType.text,
                [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
            ),
            /*labelAndTextField(
              "Total Meeting",
              controller.prospectDetailInput.totalMeeting,
              totalMeetingController,
              "number",
            ),*/
            /* labelAndTextField(
                "Premium",
                controller.prospectDetailInput.premiumPotential,
                premiumController,
                "number"),*/
            labelAndTextField(
              "Prospects Address",
              controller.prospectDetailInput.adddress,
              corporateAddressController,
              "text",
              250,
              TextCapitalization.sentences,
              TextInputType.text,
                [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
            ),

            /*labelAndTextField(
              "State",
              controller.prospectDetailInput.state,
              stateController,
              "text",
            ),*/
            const SizedBox(height: 10,),
            stateDropDown("State"),
            const SizedBox(height: 10,),
           Obx(() => cityList.isNotEmpty? cityDropDown("City"):const SizedBox.shrink()),
          /*  CSCPicker(
              flagState: CountryFlag.DISABLE,
              onCountryChanged: (value) {},
              onStateChanged: (value) {
                //state.value=value!;
                if(value!=null){
                  stateController.text = value!;
                }

              },
              onCityChanged: (value) {
                //city.value=value!;
                if(value!=null){
                  cityController.text = value!;
                }

              },
            ),*/
            /*labelAndTextField(
              "City",
              controller.prospectDetailInput.cityName,
              cityController,
              "text",
            ),*/
            pinCodeField(
              "PIN Code",
              controller.prospectDetailInput.pinCode,
              pinCodeController,
              "number",
            ),
            labelAndTextField(
              "Parent Company",
              controller.prospectDetailInput.parentCompany,
              parentController,
              "text",
              250,
              TextCapitalization.words,
              TextInputType.text,
                [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
            ),
            labelAndTextField(
              "Turn Over ",
              controller.prospectDetailInput.turnover,
              turnOverController,
              "number",
              250,
              TextCapitalization.words,
              TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly]
            ),
            const SizedBox(
              height: 10,
            ),
            /*policyDropDown("Policy Type"),
            const SizedBox(
              height: 10,
            ),*/

            /*labelAndTextField(
              "Premium Potential",
              controller.prospectDetailInput.premiumPotential,
              premiumPotentialController,
              "number",
            ),*/
            labelAndTextField(
              "Premium Achived",
              controller.prospectDetailInput.premiumAchieved,
              premiumAchivedController,
              "number",
              9,
              TextCapitalization.words,
              TextInputType.number,
                [FilteringTextInputFormatter.digitsOnly]
            ),
            const SizedBox(
              height: 10,
            ),
            verticalDropDown("Vertical"),
            const SizedBox(
              height: 10,
            ),
            industryDropDown("Industry Type"),
            const SizedBox(
              height: 10,
            ),
            labelAndTextField(
              "Write up/Notes",
              controller.prospectDetailInput.writeUp,
              writeUPController,
              "text",
              250,
              TextCapitalization.sentences,
              TextInputType.text,
                [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
            ),
            labelAndTextField(
              "Name of Reference",
              controller.prospectDetailInput.referee,
              referenceController,
              "text",
              250,
              TextCapitalization.words,
              TextInputType.text,
                [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
            ),
            savaButton()
          ],
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
                child: Text("Prospect Details",
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
  Widget pinCodeField(String label, String text,
      TextEditingController textController, String type) {
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
              maxLength: 6,
              obscureText: false,
              keyboardType:TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
  Widget labelAndTextField(String label, String text,
      TextEditingController textController, String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType,List<TextInputFormatter>? inputformator) {
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
              obscureText: false,
              keyboardType:textInputType,
              inputFormatters: inputformator,
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
  Widget integerTextField(String label, String text,
      TextEditingController textController, String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType) {
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
              obscureText: false,
              keyboardType:textInputType,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

  Widget industryDropDown(String label) {
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
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () =>
                  CustomDropdown3(
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: BoxDecoration(
                      border: Border.all(color: MyColors.kColorExtraLightGrey),
                      borderRadius: const BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select Industry',
                    dropdownItems: controller.industryType,
                    value: controller.industryTypeValue.value,
                    onChanged: (value) {
                      controller.industryTypeValue.value = value!;
                    },
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget potentialDropDown(String label) {
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
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () =>
                  CustomDropdown3(
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select Potential',
                    dropdownItems: premiumPotential,
                    value: controller.premiumPotentialValue.value,
                    onChanged: (value) {
                      controller.premiumPotentialValue.value = value!;
                    },
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget policyDropDown(String label) {
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
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () =>
                  CustomDropdown3(
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select Potential',
                    dropdownItems: policyType,
                    value: controller.policyTypeValue.value,
                    onChanged: (value) {
                      controller.policyTypeValue.value = value!;
                    },
                  ),
            ),
          )
        ],
      ),
    );
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
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () =>
                  CustomDropdown3(
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select Industry',
                    dropdownItems: vertical,
                    value: controller.verticalListValue.value,
                    onChanged: (value) {
                      controller.verticalListValue.value = value!;

                    },
                  ),
            ),
          )
        ],
      ),
    );
  }
  Widget stateDropDown(String label) {
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
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () =>
                      StateDropdown(
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select State',
                    dropdownItems: location.stateList,
                    value: location.stateValue.value,
                    onChanged: (value) {
                      location.stateValue.value = value!;
                      cityList.clear();
                      cityList.value=location.city(location.stateValue.value.id)!;
                      cityValue.value = cityList.first;

                    },
                  ),
            ),
          )
        ],
      ),
    );
  }
  Widget cityDropDown(String label) {
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
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
            width: screenWidget / 1.8,
            height: 38,
            child: Obx(
                  () =>
                  CustomDropdown5(
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                          20.0) //                 <--- border radius here
                      ),
                    ),
                    iconSize: 30,
                    hint: 'Select City',
                    dropdownItems: cityList,
                    value: cityValue.value,
                    onChanged: (value) {
                      cityValue.value = value!;
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
            textColor: Palette.kColorWhite,
            color: Palette.appColor,
            "Add Prospect", () {
          if (arguments["prospectId"] != null) {
            Get.back();
          } else {
            if (nameController.text.isEmpty) {
              Common.showToast("Please enter Prospect Name");
              return;
            }
            if (corporateAddressController.text.isEmpty) {
              Common.showToast("Please enter Prospect Address");
              return;
            }
            /*if (stateController.text.isEmpty) {
              Common.showToast("Please enter state");
              return;
            }*/
            Get.back();
            controller.addProspectDetail(
                prospectName: nameController.text,
                totalMeeting: totalMeetingController.text,
                adddress: corporateAddressController.text,
                state: location.stateValue.value.id,
                pinCode: pinCodeController.text,
                cityName:cityValue.value.id,
                industryType: controller.industryTypeValue.value.id,
                turnover: turnOverController.text,
                parentCompany: parentController.text,
                premiumClosed: premiumPotentialController.text,
                corporateOffice: corporateAddressController.text,
                premiumPotential: controller.premiumPotentialValue.value.id,
                premiumAchieved: premiumAchivedController.text,
                vertical: controller.verticalListValue.value.id,
                writeUp: writeUPController.text,
                referee: referenceController.text);
          }
        }, borderRadius: 10.0),
      ),
    );
  }
}
