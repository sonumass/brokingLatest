import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/model/prospects/viewprospects/Contactperson.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../controllers/prospects/contact_controller.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/palette.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/text_style.dart';

class ContactPreviewItemCard extends BaseStateLessWidget{
  ContactPreviewItemCard({super.key,required this.contactDetail,required this.index});
   final controller=Get.put(ContactController());
   final int index;
  final ContactItemInput contactDetail;
   final nameController = TextEditingController();
   final designationController = TextEditingController();
   final locationController = TextEditingController();
   final emailIdController = TextEditingController();
   final phone1Controller = TextEditingController();
   final phone2Controller = TextEditingController();
   final birthdayController = TextEditingController();
   final aniversaryController = TextEditingController();
   final decesionmakerController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(color: Palette.appColor,),
        labelAndTextField(
          "Name",
          contactDetail.personname,
          nameController,
        ),
        labelAndTextField(
          "Designation",
          contactDetail.designation,
          designationController,
        ),
        labelAndTextField(
          "Prospects Address",
          contactDetail.personlocation,
          locationController,
        ),
        labelAndTextField(
          "Decision Maker",
          contactDetail.decesionmaker??"",
          decesionmakerController,
        ),
        labelAndTextField(
          "Phone 1",
          contactDetail.phone,
          phone1Controller,
        ),
        labelAndTextField(
          "Phone2",
          contactDetail.phone2??"",
          phone2Controller,
        ),
        labelAndTextField(
          "Birthday",
          contactDetail.birthday??"",
         birthdayController,
        ),

        labelAndTextField(
          "Anniversary",
          contactDetail.anniversary??"",
          aniversaryController,
        ),
      ],
    );
  }
  Widget labelAndTextField(String label, String text, TextEditingController textController) {
    textController.text=text;
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
              controller: textController,
              inputFormatters: <TextInputFormatter>[
                UpperCaseTextFormatter()
              ],
              maxLines: 1,
              obscureText: false,
              onChanged:(value) {
                //controller.isValidate(index, value,contactDetail);
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 5),
                enabledBorder: OutlineInputBorder(
                  borderSide:  const BorderSide(width: 3, color: MyColors.kColorWhite),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const  BorderSide(width: 3, color: MyColors.kColorWhite),
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