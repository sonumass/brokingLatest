import 'package:broking/model/prospects/prospectinput/policy_item_input.dart';
import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../controllers/prospects/prospect_list_card_controller.dart';
import '../../../../model/ddd/login_type_data.dart';
import '../../../../model/prospects/viewprospects/Policies.dart';
import '../../../commonWidget/custom_drop_down3.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';
import '../policy_card_add_more.dart';
class PolicyPreviewCard extends BaseStateLessWidget {
  PolicyPreviewCard({super.key,required this.policies});
  final List<PolicyItemInput> policies;
  final isCollapse = false.obs;
  final renewableDateController = TextEditingController();
  final suminsuredController = TextEditingController();
  final premiumController = TextEditingController();
  final remarkController = TextEditingController();
  final docController = TextEditingController();
  RxList<LoginTypeData> policyList = [ LoginTypeData(id: "1",type:"Corporate" ),
    LoginTypeData(id: "2",type:"SME" ),
    LoginTypeData(id: "3",type:"Retail" ),
    LoginTypeData(id: "4",type:"Government" ),
    LoginTypeData(id: "5",type:"Aviation" ),].obs;
  late final Rx<LoginTypeData>  selectedValue =policyList.first.obs;
  final RxList<Widget> policyWidgetList=<Widget>[].obs;

  @override
  Widget build(BuildContext context) {
    return card;
  }

  Widget get card {
    return Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        color: Palette.cardBg,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 1, color: MyColors.themeColor)),
        child: Column(
          children: [cardHeader,visibleView],
        ));
  }

  Widget get cardHeader {
    return InkWell(
      onTap: () {
        policyWidgetList.clear();
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
                child: Text("Policy Detail",
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
    return Obx(() => isCollapse.value?Container(
      width: screenWidget,
      decoration:  const BoxDecoration(
          color: MyColors.kColorWhite,
          borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Column(children: formData,)]

        ),
      ),
    ):const SizedBox.shrink());
  }
  List<Widget> get formData {
    for(int i=0;i<=policies.length-1;i++){
      policyWidgetList.add(Container(
        decoration: const BoxDecoration(
            color: MyColors.kColorWhite,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(color: Palette.appColor,),
            const SizedBox(height: 10,),
            verticalDropDown("Policy Type"),
            const SizedBox(height: 10,),
            labelAndTextField(
              "Policy Name",
              policies[i].policyName??"",
              premiumController,
            ),
            labelAndTextField(
              "Renewables Date",
              policies[i].renewalDate??"",
              renewableDateController,
            ),
            labelAndTextField(
              "Sum insured ",
              policies[i].suminsured??"",
              suminsuredController,
            ),
            labelAndTextField(
              "Premium",
              policies[i].premium??"",
              premiumController,
            ),
            labelAndTextField(
              "Remark",
              policies[i].remarks??"",
              remarkController,
            ),
            labelAndTextField(
              "Upload Doc",
              "View Doc",
              docController,
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ));
    }

    return policyWidgetList;
  }

  Widget labelAndTextField(
      String label, String text, TextEditingController controller) {
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
              style: TextStyles.headingTexStyle(
                color: Palette.kColorBlack,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'Montserrat',
              ),
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
                hint: 'Select Item',
                dropdownItems: policyList,
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

  Widget  savaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0,top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn(
            "Add More",
                () async => {
                  PolicyAddMorePage.start(prospectId:"1")
              //loginController.callLoginApi(type: "5")
            },
            borderRadius: 10.0),
      ),
    );
  }

}
