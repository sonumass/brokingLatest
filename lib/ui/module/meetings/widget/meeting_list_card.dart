import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../data/preferences/AppPreferences.dart';
import '../../../../model/ddd/login_type_data.dart';
import '../../../../model/meeting/MeetingData.dart';
import '../../../commonWidget/custom_drop_down3.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/text_style.dart';

class MeetingCard extends BaseStateLessWidget {
   MeetingCard({super.key, required this.meetingData});

  final MeetingData meetingData;

  @override
  Widget build(BuildContext context) {
    return card;
  }
   RxList<LoginTypeData> actionPointList = [
     LoginTypeData(id: "1", type: "Cold"),
     LoginTypeData(id: "2", type: "Open"),
     LoginTypeData(id: "2", type: "Closed"),

   ].obs;
   late final Rx<LoginTypeData> actionPointValue = actionPointList.first.obs;
   final actionPointController = TextEditingController();
  Widget get card {
    return Card(
        margin: const EdgeInsets.only(top: 0,bottom: 10,left: 0,right: 0),
        elevation: 20,
        color: Palette.kColorWhite,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
            side: BorderSide(width: 0, color: MyColors.themeColor)),
        child: Padding(padding: const EdgeInsets.all(10),child: Column(
          children: [
            personName("Person:" ,meetingData.personMeet),
            rowColumn("Last Visit Date", meetingData.lastVisiDate),
            rowColumn("Last Visit Time", meetingData.lastVisitTime),
            rowColumn("Next Follow UpDate", meetingData.nextFollowUpDate),
            rowColumn("Next Follow Time", meetingData.nextFollowUpTime),
            rowColumn("Meeting Type:", "Online"),
            const SizedBox(height: 10,),
            actionPointField()

          ],
        ),));
  }

  Widget get personMeet {
    return Text(
      meetingData.personMeet,
      style: TextStyles.labelTextStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Bold.ttf"),
    );
  }
  Widget get actionPoint {
    return Text(
      meetingData.actionpoint,
      style: TextStyles.labelTextStyle(
          color: Palette.kColorBlack,
          fontFamily: "assets/font/Oswald-Bold.ttf"),
    );
  }
  Widget  actionPointField(){
    return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [labelAndTextField("Action Point",meetingData.actionpoint,actionPointController,"text"),industryDropDown("Action Type")],);
  }
   Widget labelAndTextField(String label, String text,
       TextEditingController controller,String type) {
     controller.text = text;
     return Padding(
       padding: const EdgeInsets.only(top: 0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           SizedBox(
             width: screenWidget / 2,
             child: Text(
               label,
               style: TextStyles.labelTextStyle(
                   color: Palette.kColorBlack,
                   fontFamily: "assets/font/Oswald-Bold.ttf"),
             ),
           ),
           const SizedBox(height: 5,),
           SizedBox(
             width: screenWidget / 2,
             height: 50,
             child: TextFormField(
               controller: controller,
               inputFormatters: <TextInputFormatter>[
                 UpperCaseTextFormatter()
               ],
               maxLines: 1,
               obscureText: false,
               keyboardType: type=="text"?TextInputType.none:TextInputType.none,
               decoration: InputDecoration(
                 contentPadding: const EdgeInsets.only(
                     left: 10, top: 5, bottom: 5, right: 5),
                 enabledBorder: OutlineInputBorder(
                   borderSide:
                   const BorderSide(width: .5, color: Palette.appBar),
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide:
                   const BorderSide(width: .5, color: Palette.appBar),
                   borderRadius: BorderRadius.circular(10.0),
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
       child: Column(
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
           const SizedBox(height: 5,),
           SizedBox(
             width: screenWidget / 3,
             height: 30,
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
                     hint: 'Select',
                     dropdownItems: actionPointList,
                     value: actionPointValue.value,
                     onChanged: (value) {
                       actionPointValue.value = value!;
                     },
                   ),
             ),
           )
         ],
       ),
     );
   }
   Widget personName(String label, String value) {
     return Padding(
       padding: const EdgeInsets.only(top: 10),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           SizedBox(
             width: screenWidget / 3,
             child: Text(
               "$label:",
               style: TextStyles.headingTexStyle(
                 color: Palette.kColorBlack,
                 fontSize: 15,
                 fontWeight: FontWeight.bold,
                 fontFamily: 'Montserrat',
               ),
             ),
           ),
           SizedBox(
               width: screenWidget / 2,
               child: Text(
                 value,
                 style: TextStyles.labelTextStyle(
                     color: Palette.kColorBlack,
                     fontFamily: "assets/font/Oswald-Regular.ttf"),
               ))
         ],
       ),
     );
   }
  Widget rowColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorGrey,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
              width: screenWidget / 2,
              child: Text(
                value,
                style: TextStyles.labelTextStyle(
                    color: Palette.kColorBlack,
                    fontFamily: "assets/font/Oswald-Regular.ttf"),
              ))
        ],
      ),
    );
  }
}
