import 'package:broking/controllers/prospects/prospect_detail_controller.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/prospects/contact_controller.dart';
import '../../../../model/ddd/login_type_data.dart';
import '../../../../model/prospects/viewprospects/Policies.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/palette.dart';
import '../../../commonWidget/custom_drop_down.dart';
import '../../../commonWidget/custom_drop_down3.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';

class PolicyItemCard extends BaseStateLessWidget{
  PolicyItemCard({super.key,required this.policies,required this.index});
   final controller=Get.put(ContactController());
   final int index;
  final Policies policies;
  var selectedDate = DateTime.now().obs;
   final renewableDateController = TextEditingController();
  final policyNameController = TextEditingController();
   final suminsuredController = TextEditingController();
   final premiumController = TextEditingController();
   final remarkController = TextEditingController();
  final uploadController = TextEditingController();

  RxList<LoginTypeData> verticalList = [ LoginTypeData(id: "1",type:"Corporate" ),
    LoginTypeData(id: "2",type:"SME" ),
    LoginTypeData(id: "3",type:"Retail" ),
    LoginTypeData(id: "4",type:"Government" ),
    LoginTypeData(id: "5",type:"Aviation" ),].obs;
  late final Rx<LoginTypeData>  verticalListValue =verticalList.first.obs;
   final List<Widget> policyWidgetList=[];
  
  
  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(color: Palette.appColor,),
        const SizedBox(height: 10,),
        policyTypeDropDown("Policy Type"),
        const SizedBox(height: 10,),
        /*labelAndTextField(
          "Policy Name",
          policies.policyType,
            policyNameController,
          "text",
          100,
            TextCapitalization.words,
          TextInputType.text
        ),*/
        dateTextField(
          "Renewal Date",
          renewableDateController,
            DateTime.now(),DateTime(2024)
        ),
        labelAndTextField(
          "Sum insured ",
          policies.sumInsured,
          suminsuredController,
          "number",
            12,
            TextCapitalization.words,
            TextInputType.number,
          [FilteringTextInputFormatter.digitsOnly],
        ),
        labelAndTextField(
          "Premium",
          policies.premiumPotential,
          premiumController,
          "number",
            13,
            TextCapitalization.words,
            TextInputType.number,
          [FilteringTextInputFormatter.digitsOnly],
        ),
        labelAndTextField(
          "Remark",
          policies.remark,
          remarkController,
          "text",
            100,
            TextCapitalization.sentences,
            TextInputType.text,
            [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
        ),
        labelAndTextField(
          "Upload Doc",
          policies.policyFile??"",
          uploadController,
          "text",
            250,
            TextCapitalization.words,
            TextInputType.text,
            [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
        ),
        const SizedBox(height: 10,),
        updateButton()
      ],
    );
  }
  Widget dateTextField(String label, TextEditingController dateController,DateTime firstDateTime,DateTime lastDateTime) {
    renewableDateController.text=policies.renewalDate;
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
          selectDate(dateController,firstDateTime,lastDateTime);
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
  void selectDate(TextEditingController textController,DateTime firstDateTime,DateTime lastDateTime) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: firstDateTime,
      lastDate: lastDateTime,
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;


      textController.text = DateFormat("dd-MMM-yyyy").format(pickedDate);
    }
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
   Widget updateButton() {
     return Padding(
       padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
       child: SizedBox(
         height: 45,
         child: PrimaryElevatedBtn(
             "Update",
                 () {
               final controllerData=Get.find<ProspectDetailCardController>();
               controllerData.prospectViewData?.policies[index].policyType="Policy Name";
               controllerData.prospectViewData?.policies[index].renewalDate=renewableDateController.text;
               controllerData.prospectViewData?.policies[index].sumInsured=suminsuredController.text;
               controllerData.prospectViewData?.policies[index].premiumPotential=premiumController.text;
               controllerData.prospectViewData?.policies[index].remark=remarkController.text;
               controller.editProspect(controllerData.prospectViewData!);

             },
             borderRadius: 10.0,color: Palette.backgroundBgFirst,textColor: Palette.kColorWhite,),
       ),
     );
   }
  Widget labelAndTextField(String label, String text, TextEditingController textController,String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType ,List<TextInputFormatter>? inputformator) {
    textController.text=text;
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
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
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
              textCapitalization:textCapitalization ,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 5),
                enabledBorder: OutlineInputBorder(
                  borderSide:   BorderSide(width: 1.1, color: MyColors.kColorExtraLightGrey),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:   BorderSide(width: 1.1, color: MyColors.kColorExtraLightGrey),
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

 


}