import 'package:broking/model/prospects/viewprospects/Contactperson.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/prospects/contact_controller.dart';
import '../../../../controllers/prospects/prospect_detail_controller.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/palette.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';

class ContactItemCard extends BaseStateLessWidget{
   ContactItemCard({super.key,required this.contactDetail,required this.index});
   final controller=Get.put(ContactController());
   final int index;
  final Contactperson contactDetail;
   final nameController = TextEditingController();
   final designationController = TextEditingController();
   final locationController = TextEditingController();
   final emailIdController = TextEditingController();
   final phone1Controller = TextEditingController();
   final phone2Controller = TextEditingController();
   final birthdayController = TextEditingController();
   final aniversaryController = TextEditingController();
   final decesionmakerController = TextEditingController();
   var selectedDate = DateTime.now().obs;
  
  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(color: Palette.appColor,),
        labelAndTextField(
          "Name",
          contactDetail.personName,
          nameController,
            "text",
            250,
            TextCapitalization.words,
          TextInputType.text,
            [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
        ),
        labelAndTextField(
          "Designation",
          contactDetail.designation,
          designationController,
            "text",
            250,
            TextCapitalization.words,
            TextInputType.text,
            [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
        ),
        labelAndTextField(
          "Prospects Address",
          contactDetail.personLocation,
          locationController,
            "text",
            250,
            TextCapitalization.sentences,
            TextInputType.text,
            [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
        ),
        labelAndTextField(
          "Decision Maker",
          contactDetail.decesionMaker??"",
          decesionmakerController,
            "text",
            250,
            TextCapitalization.words,
            TextInputType.text,
            [FilteringTextInputFormatter.allow(RegExp("[a-za-z0-9\u0020-\u007e-\u0024-\u00a9]")),]
        ),
        emailField(
            "Email ",
            contactDetail.email,
            emailIdController,
            "text",
            250,
            TextCapitalization.words,
            TextInputType.emailAddress,
        ),
        mobileLabelAndTextField(
          "Phone 1",
          contactDetail.phone,
          phone1Controller,
            "number",
        ),
        mobileLabelAndTextField(
          "Phone2",
          contactDetail.phone2??"",
          phone2Controller,
          "number"
        ),

        dateTextField("Birthday",contactDetail.birthday??"", birthdayController,DateTime(1900),DateTime.now()),
        dateTextField("Anniversary", contactDetail.anniversary??"",aniversaryController,DateTime(1900),DateTime.now()),
        updateButton()
      ],
    );
  }
   Widget dateTextField(String label, String text,TextEditingController dateController,DateTime firstDateTime,DateTime lastDateTime) {
     dateController.text=text;
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
   bool isEmail(String em) {

     String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

     RegExp regExp = new RegExp(p);

     return regExp.hasMatch(em);
   }
   Widget updateButton() {
     return Padding(padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
       child: SizedBox(
         height: 45,
         child: PrimaryElevatedBtn(
             "Update",
                 () {
               if(!isEmail(emailIdController.text)){
                 Common.showToast("Please enter valid email");
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
               final controllerData=Get.find<ProspectDetailCardController>();
               controllerData.prospectViewData?.contactperson[index].personName=nameController.text;
               controllerData.prospectViewData?.contactperson[index].decesionMaker=decesionmakerController.text;
               controllerData.prospectViewData?.contactperson[index].designation=designationController.text;
               controllerData.prospectViewData?.contactperson[index].personLocation=locationController.text;
               controllerData.prospectViewData?.contactperson[index].email=emailIdController.text;
               controllerData.prospectViewData?.contactperson[index].phone=phone1Controller.text;
               controllerData.prospectViewData?.contactperson[index].phone2=phone2Controller.text;
               controllerData.prospectViewData?.contactperson[index].birthday=birthdayController.text;
               controllerData.prospectViewData?.contactperson[index].anniversary=aniversaryController.text;
               controller.editProspect(controllerData.prospectViewData!);

             },
             borderRadius: 10.0,color:Palette.backgroundBgFirst,textColor: Palette.kColorWhite,),
       ),
     );
   }
  Widget labelAndTextField(String label, String text, TextEditingController textController,String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType,List<TextInputFormatter>? inputformator) {
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
              textCapitalization:textCapitalization,
              inputFormatters: inputformator,
              keyboardType:textInputType,
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
   Widget emailField(String label, String text, TextEditingController textController,String type,int maxLength,TextCapitalization textCapitalization,TextInputType textInputType) {
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
               textCapitalization:textCapitalization,
               keyboardType:textInputType,
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

   Widget mobileLabelAndTextField(String label, String text, TextEditingController textController,String type) {
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
               maxLength: 12,
               obscureText: false,
               inputFormatters: [FilteringTextInputFormatter.digitsOnly],
               keyboardType: type=="text"?TextInputType.text:TextInputType.number,
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