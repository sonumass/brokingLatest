import 'package:broking/model/prospects/prospectinput/prospect_detail_input.dart';
import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../model/ddd/login_type_data.dart';
import '../../../commonWidget/custom_drop_down.dart';
import '../../../commonWidget/custom_drop_down3.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';

class ProspectDetailPreviewCard extends BaseStateLessWidget {
  ProspectDetailPreviewCard({super.key,required this.prospectData});
  final  ProspectDetailInput prospectData;
  final isCollapse = false.obs;
  final fatherNameController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final parentController = TextEditingController();
  final turnOverController = TextEditingController();
  final premiumPotentialController = TextEditingController();
  final premiumAchivedController = TextEditingController();
  final writeUPController = TextEditingController();
  final referenceController = TextEditingController();
  RxList<LoginTypeData> industriesTypeList = [ LoginTypeData(id: "1",type:"IT" ),
    LoginTypeData(id: "2",type:"Services" ),
    LoginTypeData(id: "3",type:"Aviation" ),
    LoginTypeData(id: "4",type:"Manufacturing" ),
    LoginTypeData(id: "5",type:"Manufacturing-Power" ),
    LoginTypeData(id: "6",type:"Manufacturing-Steel" ),
    LoginTypeData(id: "7",type:"Manufacturing-Petro-Chemicals" ),
    LoginTypeData(id: "8",type:"Manufacturing-Sugar" ),
    LoginTypeData(id: "9",type:"Manufacturing-Construction" ),
    LoginTypeData(id: "10",type:"Manufacturing-Chemicals" ),
    LoginTypeData(id: "11",type:"Manufacturing-Paper" ),
    LoginTypeData(id: "12",type:"Manufacturing-FMCG" ),
    LoginTypeData(id: "13",type:"Other" ),].obs;
  RxList<LoginTypeData> verticalList = [ LoginTypeData(id: "1",type:"Corporate" ),
    LoginTypeData(id: "2",type:"SME" ),
    LoginTypeData(id: "3",type:"Retail" ),
    LoginTypeData(id: "4",type:"Government" ),
    LoginTypeData(id: "5",type:"Aviation" ),].obs;
  final loginType="0".obs;
  final isLoader = false.obs;
  Rx<LoginTypeData> get selectTypeValue =>industriesTypeList.first.obs;
  Rx<LoginTypeData> get verticalListValue =>verticalList.first.obs;


  @override
  Widget build(BuildContext context) {
    return card;
  }

  void setTextValue() {
    fatherNameController.text = "N/A";
    stateController.text = "N/A";
    cityController.text = prospectData.cityName;
    pinCodeController.text = prospectData.pinCode;
    parentController.text = "N/A";
    turnOverController.text =prospectData.turnover;
    premiumPotentialController.text = prospectData.premiumPotential;
    premiumAchivedController.text = "N/A";
    writeUPController.text = "N/A";
    referenceController.text = prospectData.referee;
    selectTypeValue.value=industriesTypeList.lastWhere((element) => element.id==prospectData.industryType);
    verticalListValue.value=verticalList.lastWhere((element) => element.id==prospectData.vertical);
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
    return Obx(() => !isCollapse.value
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
    return Obx(() => isCollapse.value
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
            "Prospects Address",
            prospectData.adddress,
            fatherNameController,
          ),
          labelAndTextField(
            "State",
            "N/A",
            stateController,
          ),
          labelAndTextField(
            "City",
            prospectData.cityName,
            cityController,
          ),
          labelAndTextField(
            "PIN Code",
            prospectData.pinCode,
            pinCodeController,
          ),
          labelAndTextField(
            "Parent Company",
            prospectData.industryType,
            parentController,
          ),
          labelAndTextField(
            "Turn Over ",
            prospectData.turnover,
            turnOverController,
          ),
          labelAndTextField(
            "Premium Potential",
            prospectData.premiumPotential,
            premiumPotentialController,
          ),
          labelAndTextField(
            "Premium Achived",
            prospectData.premiumAchieved,
            premiumAchivedController,
          ),
          const SizedBox(height: 10,),
          verticalDropDown("Vertical"),
          const SizedBox(height: 10,),
          verticalDropDown("Industry Type"),
          const SizedBox(height: 10,),
          labelAndTextField(
            "Write up/Notes",
            prospectData.writeUp,
            writeUPController,
          ),

          labelAndTextField(
            "Name of Reference",
            prospectData.referee,
            referenceController,
          ),
        ],
      ),
    );
  }

  Widget labelAndTextField(String label, String text, TextEditingController controller) {
    controller.text=text;
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
            height: 50,
            child: TextFormField(
              controller: controller,
              inputFormatters: <TextInputFormatter>[
                UpperCaseTextFormatter()
              ],
              maxLines: 1,
              obscureText: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 5),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: MyColors.kColorWhite),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 3, color: MyColors.kColorWhite),
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

  Widget  industryDropDown(String label){
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
            height: 50,
            child: Obx(
                  () => CustomDropdown3(
                icon: const Icon(Icons.arrow_drop_down),
                dropdownDecoration: const BoxDecoration(borderRadius: BorderRadius.all(
                    Radius.circular(20.0) //                 <--- border radius here
                ),),
                iconSize: 30,
                hint: 'Select Vertical',
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
  Widget  verticalDropDown(String label){
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
            height: 50,
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

  Widget  savaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0,top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn(
            "UPDATE",
                () async => {

              //loginController.callLoginApi(type: "5")
            },
            borderRadius: 10.0,color:Palette.backgroundBgFirst,textColor: Palette.kColorWhite,),
      ),
    );
  }


}
