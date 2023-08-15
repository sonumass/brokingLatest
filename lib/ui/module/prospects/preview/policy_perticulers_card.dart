import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../controllers/prospects/prospect_list_card_controller.dart';
import '../../../../model/prospects/viewprospects/Policies.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';
import '../policy_card_add_more.dart';
class PolicyCard extends BaseStateLessWidget {
  PolicyCard({super.key,required this.policies});
  final RxList<Policies> policies;
  final isCollapse = false.obs;
  final renewableDateController = TextEditingController();
  final suminsuredController = TextEditingController();
  final premiumController = TextEditingController();
  final remarkController = TextEditingController();
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
  final List<Widget> policyWidgetList=[];

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
          children: [Obx(() => Column(children: formData,)),savaButton()]

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
              policies[i].policyType??"",
              premiumController,
            ),
            labelAndTextField(
              "Renewables Date",
              policies[i].renewalDate??"",
              renewableDateController,
            ),
            labelAndTextField(
              "Sum insured ",
              policies[i].sumInsured??"",
              suminsuredController,
            ),
            labelAndTextField(
              "Premium",
              policies[i].premiumPotential??"",
              premiumController,
            ),
            labelAndTextField(
              "Remark",
              "N/A",
              remarkController,
            ),
            labelAndTextField(
              "Upload Doc",
              policies[i].policyFile??"",
              remarkController,
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
                  () => CustomDropdownButton2(
                icon: const Icon(Icons.arrow_drop_down),
                dropdownDecoration: const BoxDecoration(borderRadius: BorderRadius.all(
                    Radius.circular(20.0) //                 <--- border radius here
                ),),
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
