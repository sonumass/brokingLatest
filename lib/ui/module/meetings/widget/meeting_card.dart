import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/meeting/meeting_card_controller.dart';
import '../../../../model/ddd/login_type_data.dart';
import '../../../../model/meeting/meetingList/Actionpoint.dart';
import '../../../../model/meeting/meetingList/MeetingDataList.dart';
import '../../../../theme/my_theme.dart';
import '../../../../utils/palette.dart';
import '../../../base/base_satateless_widget.dart';
import '../../../commonWidget/custom_drop_down3.dart';
import '../../../commonWidget/intpuformater.dart';
import '../../../commonWidget/text_style.dart';

class MeetingListCard extends BaseStateLessWidget {
  MeetingListCard({super.key, required this.meetingData,required this.isFirstCardOpen});

  final MeetingDataList meetingData;
  final meetingName = TextEditingController();
  final actionPoint = TextEditingController();
  final lastMeetingDate = TextEditingController();
  final currentMeetingDate = TextEditingController();
  final currentMeetingTime = TextEditingController();
  final nextMeetingDate = TextEditingController();
  final nextMeetingTime = TextEditingController();
  final reminderMeetingDate = TextEditingController();
  final reminderMeetingTime = TextEditingController();
  final controller = Get.put(MeetingCardController());
  final isCardOpen = false.obs;
  bool isFirstCardOpen;
  RxList<LoginTypeData> meetingTypeList = [
    LoginTypeData(id: "1", type: "On Line"),
    LoginTypeData(id: "2", type: "Off Line"),
  ].obs;
  RxList<LoginTypeData> policyTypeList = [
    LoginTypeData(id: "1", type: "Cold"),
    LoginTypeData(id: "2", type: "Moderate"),
    LoginTypeData(id: "3", type: "Good"),
    LoginTypeData(id: "4", type: "Converted"),
  ].obs;
  RxList<LoginTypeData> actionPointList = [
    LoginTypeData(id: "1", type: "Open"),
    LoginTypeData(id: "2", type: "Closed"),
  ].obs;
  RxList<LoginTypeData> policyTypeListt = [
    LoginTypeData(id: "1", type: "Ear/Car"),
    LoginTypeData(id: "2", type: "Cmp"),
    LoginTypeData(id: "2", type: "Machinery Breakdown"),
  ].obs;
  late final Rx<LoginTypeData> selectTypeValue = meetingTypeList.first.obs;
  late final Rx<LoginTypeData> actionPointValue = actionPointList.first.obs;
  RxList<LoginTypeData> policyList = <LoginTypeData>[].obs;
  late final Rx<LoginTypeData> policyTypeValue = policyList.first.obs;
  RxList<Widget> actionList = <Widget>[].obs;
  RxList<Actionpoint> actionPointDataList = <Actionpoint>[].obs;
  final actionPointShow = false.obs;
  late final Rx<LoginTypeData> policyStatusValue = policyTypeList.first.obs;

  @override
  Widget build(BuildContext context) {
    isCardOpen.value=isFirstCardOpen;
    if(isFirstCardOpen){
      getActionList(meetingData.policies[0].actionpoint);
    }
    for (var element in meetingData.policies) {
      if (element.policyname.isNotEmpty) {
        policyList
            .add(LoginTypeData(id: element.policyid, type: element.policyname));
      }
    }

    return card;
  }

  Widget get card {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      color: Palette.kColorWhite,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(width: 0.0, color: Colors.transparent)),
      child: Column(
        children: [
          labelAndTextField("Prospect Name:", meetingData.prospectName),
          lastMeetingDateLabelAndTextField(
              meetingData.personMeet, "Person(s)Met:"),
          /*lastMeetingDateLabelAndTextField(
              meetingData.prospectAddress, "Address:"),*/
          lastMeetingDateLabelAndTextField(
              meetingData.lastMeetingdate, "Last Meeting Date:"),
          Obx(() => isCardOpen.value
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    lastMeetingDateLabelAndTextField("Online", "Meeting Type:"),
                    lastMeetingDateLabelAndTextField(
                        meetingData.nextMeetingdate, "Next Meeting Date:"),
                    if (policyList.isNotEmpty) policyType,
                    if (policyList.isNotEmpty)
                      SizedBox(
                          width: screenWidget,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 5, right: 5),
                            child: Card(
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: .25,
                                    color: Palette.prospectCardTextColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0)),
                              ),
                              child: Obx(
                                () => CustomDropdown3(
                                  borderColor: Colors.grey,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  dropdownDecoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            10.0) //                 <--- border radius here
                                        ),
                                  ),
                                  iconSize: 25,
                                  hint: 'Select Meeting Type',
                                  dropdownItems: policyList,
                                  value: policyTypeValue.value,
                                  onChanged: (value) {
                                    policyTypeValue.value = value!;
                                    for (var element in meetingData.policies) {
                                      if (element.policyid ==
                                          policyTypeValue.value.id) {
                                        actionList.clear();
                                        getActionList(element.actionpoint);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          )),
                    Obx(() => actionPointShow.value
                        ? Column(
                            children: actionList,
                          )
                        : const SizedBox.shrink()),
                    const SizedBox(height: 10),
                  ],
                )
              : const SizedBox.shrink()),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                isCardOpen.toggle();
              },
              child: collapseIcon,
            ),
          ),
        ],
      ),
    );
  }

  Widget get collapseIcon {
    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Obx(() => !isCardOpen.value
          ? SvgPicture.asset('assets/png/down_arrow.svg')
          : SvgPicture.asset('assets/png/up_arrow.svg')),
    );
  }

  void getActionList(List<Actionpoint> actionPoint) {
    actionList = <Widget>[].obs;
    for (var element in actionPoint) {
      actionList.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10,),
          policyStatus(element.policyStatus),
          const SizedBox(height: 10,),
          addActionPointRadio,
          actionPointText(element.actionpoint,int.parse(element.isStatus)),
        ],
      ));
    }
    if (actionPoint.isNotEmpty) {
      actionPointShow.value = true;
    }
  }

  Widget get policyType {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text("Policy:",
                    style: TextStyles.headingTexStyle(
                      color: Palette.prospectCardTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat',
                    )),
              )),
        ],
      ),
    );
  }

  Widget policyStatus(String status) {
    for (var element in policyTypeList) {
      if (element.id == status) {
        policyStatusValue.value=element;
      }
    }
    return  policyStatusField("Policy Status",policyStatusValue.value.type,);
  }

  Widget get addActionPointRadio {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 20),
      child: Row(
        children: [
          Text(
            "Add Action Point",
            textAlign: TextAlign.center,
            style: TextStyles.headingTexStyle(
              color: Palette.prospectCardTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          )
        ],
      ),
    );
  }

  Widget actionPointText(String actionPointText, int actionPointStatus) {
    final actionPointController = TextEditingController();
    actionPointValue.value = actionPointList[actionPointStatus];
    actionPointController.text=actionPointText;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidget / 2.6,
            child: SizedBox(
              width: screenWidget / 3,
              height: 100,
              child: Card(
                elevation: 10,
                color: Palette.kColorGrey,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                        width: .5, color: Palette.prospectCardTextColor)),
                child: TextFormField(
                  controller: actionPointController,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  maxLines: 5,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0, color: MyColors.kColorWhite),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0, color: MyColors.kColorWhite),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    counterText: '',
                    fillColor: Palette.kColorWhite,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: SizedBox(
              width: screenWidget / 2.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenWidget / 3.9,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                width: .25,
                                color: Palette.prospectCardTextColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(14.0)),
                          ),
                          child: Obx(
                            () => CustomDropdown3(
                              borderColor: Colors.grey,
                              icon: const Icon(Icons.arrow_drop_down),
                              dropdownDecoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10.0) //                 <--- border radius here
                                    ),
                              ),
                              iconSize: 20,
                              hint: 'Select Meeting Type',
                              dropdownItems: actionPointList,
                              value: actionPointValue.value,
                              onChanged: (value) {
                                actionPointValue.value = value!;
                              },
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  addRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<MeetingCardController>(
          builder: (_) => Radio(
              activeColor: Palette.appBar,
              value: controller.gender[btnIndex],
              groupValue: controller.select,
              onChanged: (value) => controller.onClickRadioButton(value)),
        ),
        Text(title)
      ],
    );
  }

  Widget get headerWidget {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.cardHeader,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /*const Icon(Icons.account_circle_outlined,color: Palette.kColorWhite,),*/
                Expanded(
                    child: Text(
                  "Gorge Million",
                  textAlign: TextAlign.center,
                  style: TextStyles.headingTexStyle(
                    color: Palette.kColorWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Delhi Road Raopur.",
              style: TextStyles.headingTexStyle(
                color: Palette.kColorWhite,
                fontSize: 12,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat',
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget lastMeetingDateLabelAndTextField(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3,
              child: Text(text,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  ))),
          SizedBox(
              width: screenWidget / 2.2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(label,
                    textAlign: TextAlign.start,
                    style: TextStyles.headingTexStyle(
                        color: Palette.prospectCardTextColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat')),
              ))
        ],
      ),
    );
  }

  Widget labelAndTextField(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.account_box,
            color: Palette.prospectCardTextColor,
          ),
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.prospectCardTextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
            width: screenWidget / 2.2,
            height: 40,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  )),
            ),
          )
        ],
      ),
    );
  }
  Widget policyStatusField(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.prospectCardTextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: SizedBox(
              width: screenWidget / 2.2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenWidget / 3.9,
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Card(
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                width: .25,
                                color: Palette.prospectCardTextColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(14.0)),
                          ),
                          child: Obx(
                                () => CustomDropdown3(
                              borderColor: Colors.grey,
                              icon: const Icon(Icons.arrow_drop_down),
                              dropdownDecoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                ),
                              ),
                              iconSize: 20,
                              hint: 'Select Meeting Type',
                              dropdownItems: policyTypeList,
                              value: policyStatusValue.value,
                              onChanged: (value) {
                                policyStatusValue.value = value!;
                              },
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget dateTimeTextField(String label, TextEditingController textController) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3.5,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(width: 0.0, color: Palette.appBar)),
            child: SizedBox(
                width: screenWidget / 2,
                height: 50,
                child: TextFormField(
                  controller: textController,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter()
                  ],
                  maxLines: 1,
                  obscureText: false,
                  onTap: () {
                    controller.selectDate(textController);
                  },
                  decoration: InputDecoration(
                    hintText: "dd-mm-yyyy",
                    suffixIcon: const Icon(Icons.calendar_month),
                    contentPadding: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0, color: MyColors.kColorWhite),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0, color: MyColors.kColorWhite),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    counterText: '',
                    fillColor: const Color(0xfff3f3f4),
                    filled: true,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget meetingType(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Text(label,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ))),
          SizedBox(
              width: screenWidget / 1.9,
              height: 40,
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      width: .25, color: Palette.prospectCardTextColor),
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                ),
                child: Obx(
                  () => CustomDropdown3(
                    borderColor: Colors.grey,
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                              10.0) //                 <--- border radius here
                          ),
                    ),
                    iconSize: 30,
                    hint: 'Select Meeting Type',
                    dropdownItems: meetingTypeList,
                    value: selectTypeValue.value,
                    onChanged: (value) {
                      selectTypeValue.value = value!;
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget currentMeetingType(String label, TextEditingController dateController,
      TextEditingController timeController) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3.5,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
              width: screenWidget / 1.9,
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: .25, color: Palette.appBar),
                      borderRadius: BorderRadius.all(Radius.circular(60.0)),
                    ),
                    child: TextFormField(
                      controller: dateController,
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter()
                      ],
                      maxLines: 1,
                      obscureText: false,
                      onTap: () {
                        controller.selectDate(dateController);
                      },
                      decoration: InputDecoration(
                        hintText: "dd-mm-yyyy",
                        suffixIcon: const Icon(Icons.calendar_month),
                        contentPadding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        counterText: '',
                        fillColor: const Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 10,
                    color: Palette.appColor,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: .25, color: Palette.appBar),
                      borderRadius: BorderRadius.all(Radius.circular(11.0)),
                    ),
                    child: TextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "HH:MM",
                        suffixIcon: const Icon(Icons.access_time),
                        contentPadding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        counterText: '',
                        fillColor: const Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget nextMeetingType(String label, TextEditingController dateController,
      TextEditingController timeController) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3.25,
            child: Text(
              label,
              style: TextStyles.headingTexStyle(
                color: Palette.prospectCardTextColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(
              width: screenWidget / 1.9,
              child: Column(
                children: [
                  SizedBox(
                      height: 40,
                      child: Card(
                          elevation: 10,
                          color: Palette.kColorWhite,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                                width: .5,
                                color: Palette.prospectCardTextColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.0)),
                          ),
                          child: TextFormField(
                              controller: dateController,
                              inputFormatters: <TextInputFormatter>[
                                UpperCaseTextFormatter()
                              ],
                              maxLines: 1,
                              obscureText: false,
                              onTap: () {
                                controller.selectDate(dateController,
                                    type: "nextMeetingDate");
                              },
                              decoration: InputDecoration(
                                hintText: "dd-mm-yyyy",
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                  color: Palette.prospectCardTextColor,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5, right: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0, color: MyColors.kColorWhite),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0, color: MyColors.kColorWhite),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                counterText: '',
                                fillColor: Palette.kColorWhite,
                                filled: true,
                              ))))
                ],
              )),
        ],
      ),
    );
  }

  Widget policyTypee(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 2.5,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
              width: screenWidget / 2.5,
              height: 55,
              child: Card(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(width: .25, color: Palette.appBar),
                  borderRadius: BorderRadius.all(Radius.circular(13.0)),
                ),
                child: Obx(
                  () => CustomDropdown3(
                    borderColor: Colors.white,
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownDecoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(
                              10.0) //                 <--- border radius here
                          ),
                    ),
                    iconSize: 30,
                    hint: 'Select Policy Type',
                    dropdownItems: policyTypeList,
                    value: policyTypeValue.value,
                    onChanged: (value) {
                      policyTypeValue.value = value!;
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget reminderMeetingType(String label, TextEditingController dateController,
      TextEditingController timeController) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidget / 3.5,
            child: Text(
              label,
              style: TextStyles.labelTextStyle(
                  color: Palette.kColorBlack,
                  fontFamily: "assets/font/Oswald-Bold.ttf"),
            ),
          ),
          SizedBox(
              width: screenWidget / 1.9,
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: .25, color: Palette.appBar),
                      borderRadius: BorderRadius.all(Radius.circular(11.0)),
                    ),
                    child: TextFormField(
                      controller: dateController,
                      inputFormatters: <TextInputFormatter>[
                        UpperCaseTextFormatter()
                      ],
                      maxLines: 1,
                      obscureText: false,
                      onTap: () {
                        controller.selectDate(dateController);
                      },
                      decoration: InputDecoration(
                        hintText: "dd-mm-yyyy",
                        suffixIcon: const Icon(Icons.calendar_month),
                        contentPadding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        counterText: '',
                        fillColor: const Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 10,
                    color: Palette.appBar,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(width: .25, color: Palette.appBar),
                      borderRadius: BorderRadius.all(Radius.circular(11.0)),
                    ),
                    child: TextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "HH:MM",
                        suffixIcon: const Icon(Icons.access_time),
                        contentPadding: const EdgeInsets.only(
                            left: 10, top: 5, bottom: 5, right: 5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, color: MyColors.kColorWhite),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        counterText: '',
                        fillColor: const Color(0xfff3f3f4),
                        filled: true,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
