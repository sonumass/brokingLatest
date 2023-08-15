import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../controllers/location_controller.dart';
import '../../../../controllers/prospects/contact_controller.dart';
import '../../../../controllers/prospects/prospect_detail_controller.dart';
import '../../../../model/ddd/city_data.dart';
import '../../../../model/ddd/login_type_data.dart';
import '../../../../model/prospects/viewprospects/ProspectDetails.dart';
import '../../../commonWidget/custom_drop_down3.dart';
import '../../../commonWidget/custom_drop_down5.dart';
import '../../../commonWidget/custom_drop_down_state.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';

class ProspectDetailCard extends BaseStateLessWidget {
  ProspectDetailCard({super.key, required this.prospectData});

  final ProspectDetails prospectData;
  final controller = Get.put(ContactController());
  final location = Get.put(LocationController());
  final isCollapse = false.obs;
  final nameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final premiumController = TextEditingController();
  final addressController = TextEditingController();
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
  RxList<CityData> cityList = <CityData>[].obs;
  late final Rx<CityData> cityValue = cityList.first.obs;
  RxList<LoginTypeData> industriesTypeList = [
    LoginTypeData(id: "1", type: "IT"),
    LoginTypeData(id: "2", type: "Services"),
    LoginTypeData(id: "3", type: "Aviation"),
    LoginTypeData(id: "4", type: "Manufacturing"),
    LoginTypeData(id: "5", type: "Manufacturing-Power"),
    LoginTypeData(id: "6", type: "Manufacturing-Steel"),
    LoginTypeData(id: "7", type: "Manufacturing-Petro-Chemicals"),
    LoginTypeData(id: "8", type: "Manufacturing-Sugar"),
    LoginTypeData(id: "9", type: "Manufacturing-Construction"),
    LoginTypeData(id: "10", type: "Manufacturing-Chemicals"),
    LoginTypeData(id: "11", type: "Manufacturing-Paper"),
    LoginTypeData(id: "12", type: "Manufacturing-FMCG"),
    LoginTypeData(id: "13", type: "Other"),
  ].obs;
  RxList<LoginTypeData> verticalList = [
    LoginTypeData(id: "1", type: "Corporate"),
    LoginTypeData(id: "2", type: "SME"),
    LoginTypeData(id: "3", type: "Retail"),
    LoginTypeData(id: "4", type: "Government"),
    LoginTypeData(id: "5", type: "Aviation"),
  ].obs;

  late final Rx<LoginTypeData> verticalListValue = verticalList.first.obs;
  late final Rx<LoginTypeData> selectTypeValue = industriesTypeList.first.obs;

  @override
  Widget build(BuildContext context) {
    return card;
  }

  void setTextValue() {
    nameController.text = prospectData.prospectName;
    fatherNameController.text = "N/A";
    stateController.text = "N/A";
    premiumController.text = prospectData.premiumPotential;
    addressController.text = prospectData.adddress;
    cityController.text = prospectData.cityName;
    pinCodeController.text = prospectData.pinCode;
    parentController.text = prospectData.parentCompany;
    turnOverController.text = prospectData.turnover;
    premiumPotentialController.text = prospectData.premiumClosed;
    premiumAchivedController.text = prospectData.premiumAchived;
    writeUPController.text = prospectData.writeupNotes;
    totalMeetingController.text = prospectData.totalMeeting;
    referenceController.text = prospectData.referee;
  }

  Widget get card {
    setTextValue();
    return Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        color: Palette.cardBg,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 1, color: MyColors.themeColor)),
        child: Column(
          children: [cardHeader, visibleView],
        ));
  }

  Widget get cardHeader {
    return InkWell(
      onTap: () {
        isCollapse.toggle();
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
                child: Text("Prospects Detail",
                    style: TextStyles.headingTexStyle(
                        color: Palette.textOnThemeBg,
                        fontFamily: "assets/font/Oswald-Bold.ttf")),
              )
            ],
          ),
          collapseIcon
        ],
      ),
    );
  }

  Widget get collapseIcon {
    return Obx(() =>
    !isCollapse.value
        ? const Icon(
      Icons.arrow_drop_down,
      color: Palette.kColorWhite,
    )
        : const Icon(
      Icons.arrow_drop_up_outlined,
      color: Palette.kColorWhite,
    ));
  }

  Widget get visibleView {
    return Obx(() =>
    isCollapse.value
        ? Container(
      width: screenWidget,
      decoration: const BoxDecoration(
          color: MyColors.kColorWhite,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [formData],
        ),
      ),
    )
        : const SizedBox.shrink());
  }

  Widget get formData {
    return Container(
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
            prospectData.prospectName,
            nameController,
            "text",
              250,
              TextCapitalization.words,
              TextInputType.text,
              [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]),
          /*labelAndTextField(
            "Total Meeting",
            prospectData.totalMeeting,
            totalMeetingController,
            "number",
          ),
          labelAndTextField(
            "Premium",
            prospectData.premiumPotential,
            premiumController,
            "number",
          ),*/
          labelAndTextField(
            "Prospects Address",
            prospectData.adddress,
            addressController,
            "text",
              250,
              TextCapitalization.words,
              TextInputType.text,
              [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
          ),
          /*labelAndTextField(
            "State",
            "N/A",
            stateController,
            "text",
          ),*/
         const  SizedBox(height: 10,),
          stateDropDown("State"),
          const  SizedBox(height: 10,),
          cityDropDown("City"),
          /*labelAndTextField(
            "City",
            prospectData.cityName,
            cityController,
            "text",
          ),*/
          pinCodeField(
            "PIN Code",
            prospectData.pinCode,
            pinCodeController,
            "number"
          ),
          labelAndTextField(
            "Parent Company",
            prospectData.parentCompany,
            parentController,
            "text",
              250,
              TextCapitalization.words,
              TextInputType.text,
              [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
          ),
          labelAndTextField(
            "Turn Over ",
            prospectData.turnover,
            turnOverController,
            "number",
              9,
              TextCapitalization.words,
              TextInputType.number,
            [FilteringTextInputFormatter.digitsOnly],
          ),

          labelAndTextField(
            "Premium Achived",
            prospectData.premiumAchived,
            premiumAchivedController,
            "number",
              9,
              TextCapitalization.words,
              TextInputType.number,
            [FilteringTextInputFormatter.digitsOnly],
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
          writeUpField(
            "Write up/Notes",
            prospectData.writeupNotes,
            writeUPController,
            "text",

          ),
          labelAndTextField(
            "Name of Reference",
            prospectData.referee,
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
    );
  }
  Widget writeUpField(String label, String text,
      TextEditingController controller,String type) {
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
              textCapitalization: TextCapitalization.sentences,
              maxLines: 1,
              obscureText: false,
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 5),
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
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget labelAndTextField(String label, String text,
      TextEditingController controller,String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType,List<TextInputFormatter>? inputFormatters) {
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
              maxLength: maxLength,
              maxLines: 1,
              obscureText: false,
              keyboardType:textInputType,
              inputFormatters: inputFormatters,
              textCapitalization: textCapitalization,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 5),
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
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget pinCodeField(String label, String text,
      TextEditingController controller,String type) {
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
              maxLength: 6,
              maxLines: 1,
              obscureText: false,
              keyboardType:TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 5),
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
                    dropdownItems: industriesTypeList,
                    value: selectTypeValue.value,
                    onChanged: (value) {
                      selectTypeValue.value = value!;
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
              style: TextStyles.headingTexStyle(
                color: Palette.textHeadingColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
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

  Widget savaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn(
            "Update",
                () {
/*
                  final nameController = TextEditingController();
                  final fatherNameController = TextEditingController();
                  final premiumController = TextEditingController();
                  final addressController = TextEditingController();
                  final totalMeetingController = TextEditingController();
                  final stateController = TextEditingController();
                  final cityController = TextEditingController();
                  final pinCodeController = TextEditingController();
                  final parentController = TextEditingController();
                  final turnOverController = TextEditingController();
                  final premiumPotentialController = TextEditingController();
                  final premiumAchivedController = TextEditingController();
                  final writeUPController = TextEditingController();
                  final referenceController = TextEditingController();*/
              final controllerData = Get.find<ProspectDetailCardController>();
              prospectData.prospectName =nameController.text;
                  prospectData.premiumPotential =premiumPotentialController.text;
                  prospectData.adddress =addressController.text;
                  prospectData.totalMeeting =totalMeetingController.text;
                  prospectData.cityName =cityValue.value.id;
                  prospectData.pinCode =pinCodeController.text;
                  prospectData.parentCompany =parentController.text;
                  prospectData.turnover =turnOverController.text;
                  prospectData.premiumAchived =premiumAchivedController.text;
                  prospectData.premiumClosed =premiumAchivedController.text;
                  prospectData.writeupNotes =writeUPController.text;
                  prospectData.referee =referenceController.text;
                  controllerData.prospectViewData!.prospectDetails=prospectData;
                  controller.editProspect(controllerData.prospectViewData!);

            },
            borderRadius: 10.0,color:Palette.backgroundBgFirst,textColor: Palette.kColorWhite,),
      ),
    );
  }


}
