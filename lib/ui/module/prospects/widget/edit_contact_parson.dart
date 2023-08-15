import 'package:broking/controllers/prospects/contact_controller.dart';
import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/base/base_satateless_widget.dart';
import 'package:broking/ui/module/prospects/widget/contact__item_card.dart';
import 'package:broking/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controllers/prospects/prospect_list_controller.dart';
import '../../../../model/prospects/viewprospects/Contactperson.dart';
import '../../../commonWidget/primary_elevated_button.dart';
import '../../../commonWidget/text_style.dart';
import '../contact_card_add_more.dart';

class ContactCard extends BaseStateLessWidget {
  ContactCard({super.key, required this.contactperson});
  final controller=Get.put(ContactController());
  final List<Contactperson> contactperson;
  final isCollapse = false.obs;
  final RxList<ContactItemCard> contactList = <ContactItemCard>[].obs;
  final contactCount = 1.obs;
  var selectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    return contactperson.isNotEmpty ? card : const SizedBox.shrink();
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
  Widget get card {
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
        contactList.clear();
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
                child: Text("Contact Details",
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
          Obx(() => Column(
            children: list,
          )),

         // savaButton()
        ],
      ),
    );
  }

  List<Widget> get list {
    for ( int i=0;i<=contactperson.length-1;i++) {
      contactList.add(ContactItemCard(contactDetail: contactperson[i],index:i));
    }
    return contactList;
  }

  Widget get addMore {
    return InkWell(
      onTap: () {
        ContactAddMorePage.start(prospectId:contactperson[0].prospectId);
       // controller.contactInputDataList.add(ContactItemInput(contactpersonid:"", prospectid: contactperson.last.prospectid, personname: "", designation: "", personlocation: "", email: "", phone: "", decesionmaker: "", phone2: "", birthday: "", anniversary: ""));
       /* contactList.add(ContactItemCard(contactDetail: Contactperson(
          contactpersonid:"",
          prospectid:"",
          personname:"",
          designation:"",
          personlocation:"",
          email:"",
          phone:"",
          decesionmaker:"",
          phone2:"",
          birthday:"",
          anniversary:"",),index:contactperson.length+1));*/

      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 10, top: 20),
          child: Text("Add More",
              style: TextStyles.headingTexStyle(
                  color: Palette.appColor,
                  fontFamily: "assets/font/Oswald-Bold.ttf")),
        ),
      ),
    );
  }

  Widget savaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
      child: SizedBox(
        height: 45,
        child: PrimaryElevatedBtn(
            "Add more",
            () async => {
              ContactAddMorePage.start(prospectId:contactperson[0].prospectId)

        },
            borderRadius: 10.0),
      ),
    );
  }
}
