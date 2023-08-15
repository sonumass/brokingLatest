import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:broking/ui/base/page.dart';
import 'package:broking/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multiselect/multiselect.dart';
import '../../../controllers/meeting/meeting_create_controller.dart';
import '../../../controllers/meeting/meeting_list_controller.dart';
import '../../../data/preferences/AppPreferences.dart';
import '../../../model/ddd/login_type_data.dart';
import '../../../model/meeting/meeting_input_type.dart';
import '../../../services/navigator.dart';
import '../../../theme/my_theme.dart';
import '../../../utils/palette.dart';
import '../../commonWidget/custom_drop_down3.dart';
import '../../commonWidget/intpuformater.dart';
import '../../commonWidget/primary_elevated_button.dart';
import '../../commonWidget/text_style.dart';

class CreateMeeting extends AppPageWithAppBar {
  static const String routeName = "/CreateMeeting";
  final controller = Get.put(MeetingCreateController());
  final appPreferences = Get.find<AppPreferences>();
  RxList<String> selectedPolicy = <String>[].obs;

  CreateMeeting({super.key});

  @override
  double? get toolbarHeight => 0;
  final meetingName = TextEditingController();
  final actionPoint = TextEditingController();
  final lastMeetingDate = TextEditingController();
  final currentMeetingDate = TextEditingController();
  final currentMeetingTime = TextEditingController();
  final nextMeetingDate = TextEditingController();
  final nextMeetingTime = TextEditingController();
  final reminderMeetingDate = TextEditingController();
  final reminderMeetingTime = TextEditingController();
  final actionPointIndex = 0.obs;
  String policyId = "";
  RxList<Widget> actionPointListUi = <Widget>[].obs;
  RxList<LoginTypeData> meetingTypeList = [
    LoginTypeData(id: "1", type: "Online"),
    LoginTypeData(id: "2", type: "Offline"),
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
  RxList<LoginTypeData> policy = [
    LoginTypeData(id: "1", type: "Policy 1"),
    LoginTypeData(id: "2", type: "Policy 2"),
  ].obs;
  RxList<LoginTypeData> contactPerson = [
    LoginTypeData(id: "1", type: "Raj"),
    LoginTypeData(id: "2", type: "Monit"),
  ].obs;
  RxString time = "00".obs;
  bool check = false;
  late final Rx<LoginTypeData> selectPolicyValue = policy.first.obs;
  late final Rx<LoginTypeData> selectTypeValue = meetingTypeList.first.obs;
  late final Rx<LoginTypeData> policyTypeValue = policyTypeList.first.obs;
  late final Rx<LoginTypeData> policyTypeListtValue = policyTypeListt.first.obs;
  late final Rx<LoginTypeData> actionPointValue = actionPointList.first.obs;
  late final Rx<LoginTypeData> contactPersonValue = contactPerson.first.obs;

  static Future<bool?> start<bool>(
      String prospectId, String name, String address) {
    return navigateTo<bool>(currentPageTitle: "Meeting", routeName, arguments: {
      "prospectId": prospectId,
      "name": name,
      "address": address,
    });
  }

  @override
  Widget get body {
    // Create an alarm at 23:59

    controller.getMeetingDataApi(arguments['prospectId']);
    return Scaffold(
      backgroundColor: Palette.backgroundBg,
      body: Obx(() => controller.isLoader.value
          ? const SizedBox.shrink()
          : SizedBox(
              width: screenWidget,
              height: screenHeight,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/png/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        appBarWidget,
                        myText,
                        card,
                      ],
                    ),
                  ),
                ),
              ),
            )),
    );
  }

  Widget get appBarWidget {
    return Column(
      children: [
        const PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: SizedBox(
            height: 50,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: SvgPicture.asset(
                    width: 25, height: 25, 'assets/png/back_bar.svg'),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50,
                height: 50,
                child: SvgPicture.network("https://3ditec.co.in/broking/assets/images/crownlogo.svg"),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 15, top: 8, bottom: 8),
                child: Stack(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset('assets/png/ic_notification.svg'),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerWidget,
          lastMeetingDateLabelAndTextField(
            "Last Meeting Date",
            controller.meetings.isNotEmpty?controller.meetings[0].lastMeetinDate:"",
          ),
          meetingType("Meeting Type"),
          const SizedBox(height: 10),
          nextMeetingType(
              "Next Meeting Date", nextMeetingDate, nextMeetingTime),
          nextMeetingTimeField("Next Meeting Time",nextMeetingTime),
          const SizedBox(height: 10),
          personDropDownType(
            "Contact Person",
          ),
          const SizedBox(height: 10),
          reminderOn,
          Column(children: policyTypeColumn),
          Obx(() => controller.selectedPolicy.isTrue?actionPointMainUI(actionPointIndex.value):const SizedBox.shrink()),
          const SizedBox(height: 10),
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  controller.selectedPolicy.value
                      ? saveButton()
                      : const SizedBox.shrink(),
                  if (controller.selectedPolicy.value) viewHistoryButton()
                ],
              )),
          Center(
            child: createButton(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget get reminderOn {
    return SizedBox(
        height: 120,
        width: screenWidget,
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                  top: 30,
                  left: 10,
                  right: 10,
                  bottom: 20,
                  child: Container(
                    height: 100,
                    width: screenWidget,
                    decoration: BoxDecoration(
                        color: Palette.kColorWhite,
                        border:
                            Border.all(color: Palette.prospectCardTextColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  )),
              Positioned(
                  top: 20,
                  left: screenWidget / 3.8,
                  child: SizedBox(
                    height: 20,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      color: Palette.kColorWhite,
                      child: const Text("Reminder me on"),
                    ),
                  )),
              Positioned(
                  top: 45,
                  left: 10,
                  right: 10,
                  child: SizedBox(
                    height: 40,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: screenWidget / 2.4,
                            height: 40,
                            child: Card(
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: .25, color: Palette.appBar),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60.0)),
                              ),
                              child: TextFormField(
                                controller: reminderMeetingDate,
                                keyboardType: TextInputType.none,
                                maxLines: 1,
                                obscureText: false,
                                onTap: () {
                                  controller
                                      .reminderSelectDate(reminderMeetingDate);
                                },
                                decoration: InputDecoration(
                                  hintText: "Date",
                                  suffixIcon: const Icon(Icons.calendar_month,
                                      color: Palette.prospectCardTextColor),
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
                          ),
                          SizedBox(
                            width: screenWidget / 3.2,
                            height: 40,
                            child: Card(
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: .25, color: Palette.appBar),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60.0)),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.none,
                                controller: reminderMeetingTime,
                                maxLines: 1,
                                obscureText: false,
                                enabled: true,
                                onTap: () {
                                  showTimePicker(
                                          context: Get.context!,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {reminderMeetingTime
                                          .text = value!.format(Get.context!);
                                      controller.hours=value.hour;
                                      controller.mints=value.minute;});
                                  //controller.selectDate(dateController);
                                },
                                decoration: InputDecoration(
                                  hintText: "Time",
                                  suffixIcon: const Icon(
                                    Icons.timer,
                                    color: Palette.prospectCardTextColor,
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget get policySection {
    List<String> fruits = ['Apple', 'Banana', 'Graps', 'Orange', 'Mango'];
    List<String> selectedFruits = [];
    return SizedBox(
        width: screenWidget / 2.8,
        height: 45,
        child: DropDownMultiSelect(
          options: fruits,
          selectedValues: selectedFruits,
          enabled: true,
          onChanged: (value) {
            //print('selected fruit $value');

            selectedFruits = value;

            // print('you have selected $selectedFruits fruits.');
          },
          whenEmpty: 'Select your favorite fruits',
        ));
  }

  Widget get policyType {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: policyTypeColumn,
    );
  }

  // Widget get policyDropdown{
  //
  //   List<bool> _isChecked = List.filled(2, false);
  //   return StatefulBuilder(builder: (context, setState) {
  //     return Container(
  //       height: 20,
  //       width: 90,
  //       child: DropdownButton<String>(
  //         items: policy.map((String value) {
  //           int index = policy.indexOf(value);
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Row(
  //               children: [
  //               Obx(()=>Checkbox(
  //               checkColor: Palette.kColorWhite,
  //               activeColor: Palette.appBar,
  //               value: controller.selectedPolicy.value,
  //
  //               onChanged: (value) {
  //                 controller.selectedPolicy.value = value!;
  //               },
  //             )),
  //                 // Checkbox(
  //                 //   value: _isChecked[index],
  //                 //   onChanged: (value) {
  //                 //     setState(() {
  //                 //       _isChecked[index] = value!;
  //                 //     });
  //                 //   },
  //                 // ),
  //                 Text(value),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //         onChanged: (String? value) {
  //           setState((){
  //
  //           });
  //           value =value;
  //         },
  //       ),
  //     );
  //   });
  // }
  List<Widget> get policyTypeColumn {
    List<Widget> list = [];
    for (var i = 0; i < controller.policy.length; i++) {
      list.add(Row(
        children: [
          Obx(() => Checkbox(
                checkColor: Palette.kColorWhite,
                activeColor: Palette.appBar,
                value: controller.policy[i].isCheck.value,
                shape: const CircleBorder(),
                onChanged: (value) {
                  if (value!) {
                    //actionPointInputList.clear();
                    policyId = controller.policy[i].id;
                    actionPoint.text = "";
                  } else {
                    if (controller.actionPointInputList.isNotEmpty) {
                      /* controller.actionPointInputList.removeWhere(
                          (element) => element.policyId == controller.policy[i].id);*/
                    }
                  }
                  controller.policy[i].isCheck.value = value;
                  controller.selectedPolicy.value = value;
                  actionPointIndex.value = i;
                },
              )),
          Text(
            controller.policy[i].type,
            textAlign: TextAlign.center,
            style: TextStyles.headingTexStyle(
              color: Palette.prospectCardTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ],
      ));
    }
    return list;
  }

  RxList<Widget> addActionPointRadioListUi() {
    actionPointListUi.clear();
    actionPointListUi.add(actionPointTextWithDropDown());
    return actionPointListUi;
  }

  Widget actionPointTextWithDropDown() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (actionPointListUi.length > 1)
            const Divider(
              color: Palette.appColor,
              height: .5,
            ),
          SizedBox(
              width: screenWidget / 2.8,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
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
                      iconSize: 20,
                      hint: 'Select Meeting Type',
                      dropdownItems: policyTypeList,
                      value: policyTypeValue.value,
                      onChanged: (value) {
                        policyTypeValue.value = value!;
                      },
                    ),
                  ),
                ),
              )),
          Row(
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
              ),
              /*Obx(() => Checkbox(
                    checkColor: Palette.kColorWhite,
                    activeColor: Palette.appBar,
                    value: controller.selectedActionPoint.value,
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      controller.selectedActionPoint.value = value!;
                    },
                  ))*/
            ],
          ),
          atAddActionPointText
        ],
      ),
    );
  }

  Widget actionPointMainUI(int index) {

    return Obx(() => controller.selectedPolicy.isTrue
        ? Obx(() => Column(
              children: [actionPointTextWithDropDown()],
            ))
        : const SizedBox());
  }

  Widget get atAddActionPointText {
    return Obx(() => controller.selectedPolicy.isTrue
        ? Padding(
            padding: const EdgeInsets.only(left: 5, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: screenWidget / 2.5,
                  child: SizedBox(
                    width: screenWidget / 3,
                    height: 100,
                    child: Card(
                      elevation: 10,
                      color: Palette.kColorWhite,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(
                              width: .5, color: Palette.prospectCardTextColor)),
                      child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          UpperCaseTextFormatter()
                        ],
                        maxLines: 5,
                        obscureText: false,
                        controller: actionPoint,
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
                SizedBox(
                  width: screenWidget / 2.8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: screenWidget / 3,
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
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
                      const SizedBox(
                        width: 5,
                      ),
                      // InkWell(onTap: (){},child:const Icon(Icons.add,color:Palette.appColor,size: 30)),
                      // InkWell(onTap: (){},child: Container(height:2,width:17,margin:const EdgeInsets.only(top:13,left: 5),decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage("assets/png/ic_min.png"),
                      //     fit: BoxFit.cover,
                      //   ),
                      // )),),
                    ],
                  ),
                )
              ],
            ),
          )
        : const SizedBox());
  }

  addRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<MeetingController>(
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
                  arguments["name"],
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
              arguments["address"],
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

  Widget lastMeetingDateLabelAndTextField(String text, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: screenWidget / 3.5,
              child: Text(text,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ))),
          labelAndTextField(label, "", lastMeetingDate, ""),
          // SizedBox(
          //     width: screenWidget / 1.9,
          //     height: 40,
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(label,
          //           textAlign: TextAlign.start,
          //           style: TextStyles.headingTexStyle(
          //               color: Palette.prospectCardTextColor,
          //               fontSize: 15,
          //               fontWeight: FontWeight.w300,
          //               fontFamily: 'Montserrat')),
          //     ))
        ],
      ),
    );
  }

  Widget labelAndTextField(
      String text, String hint, TextEditingController controller, String type) {
    controller.text = text;
    return Padding(
      padding: const EdgeInsets.only(left: 7, right: 0, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          SizedBox(
            width: screenWidget / 1.9,
            height: 40,
            child: Card(
              elevation: 10,
              color: Palette.kColorWhite,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  side: BorderSide(
                      width: .5, color: Palette.prospectCardTextColor)),
              child: TextFormField(
                controller: controller,
                inputFormatters: <TextInputFormatter>[UpperCaseTextFormatter()],
                maxLines: 1,
                enabled: text.toLowerCase().contains("last Meeting Date")?true:false,
                obscureText: false,
                keyboardType:
                    type == "text" ? TextInputType.text : TextInputType.number,
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 5),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: MyColors.kColorWhite),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  disabledBorder:OutlineInputBorder(
                    borderSide:
                    const BorderSide(width: 0, color: MyColors.kColorWhite),
                    borderRadius: BorderRadius.circular(60.0),
                  ) ,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0, color: MyColors.kColorWhite),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  counterText: '',
                  fillColor: Palette.kColorWhite,
                  filled: true,
                ),
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

  Widget personDropDownType(String label) {
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
                    hint: 'Select contact',
                    dropdownItems: controller.personList,
                    value: controller.personValue.value,
                    onChanged: (value) {
                      controller.personValue.value = value!;
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
                      keyboardType: TextInputType.none,
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
      padding: const EdgeInsets.only(left: 10, right: 9, top: 10),
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
                              keyboardType: TextInputType.none,
                              showCursor: false,
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
  Widget nextMeetingTimeField(String label, TextEditingController timeController) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 9, top: 10),
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
                            keyboardType: TextInputType.none,
                            controller: nextMeetingTime,
                            maxLines: 1,
                            obscureText: false,
                            enabled: true,
                            onTap: () {
                              showTimePicker(
                                  context: Get.context!,
                                  initialTime: TimeOfDay.now())
                                  .then((value) => nextMeetingTime
                                  .text = value!.format(Get.context!));
                              //controller.selectDate(dateController);
                            },
                            decoration: InputDecoration(
                              hintText: "Time",
                              suffixIcon: const Icon(
                                Icons.timer,
                                color: Palette.prospectCardTextColor,
                              ),
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
                          ))
                ],
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
                      showCursor: false,
                      keyboardType: TextInputType.none,
                      maxLines: 1,
                      obscureText: false,
                      onTap: () {
                        controller.reminderSelectDate(dateController);
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
                      keyboardType: TextInputType.none,
                      showCursor: false,
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

  Widget get myText {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "My",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Text(
                "Meeting",
                style: TextStyles.headingTexStyle(
                  color: Palette.kColorWhite,
                  fontSize: 22,
                  height: 10,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
        SvgPicture.asset(width: 80, height: 80, 'assets/png/actar.svg')
      ],
    );
  }

  Widget saveButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget / 3,
        height: 40,
        child: PrimaryElevatedBtn(
            color: Palette.backgroundBgFirst,
            textColor: Palette.kColorWhite,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            "ADD ACTION", () {
          Common.showToast("Action point added successfully.");

          controller.actionPointInputList.add(ActionPointInputModel(
              policyId: policyId,
              actionPointText: actionPoint.text,
              policyStatus: policyTypeValue.value.id,
              openClosedStatus: actionPointValue.value.id));
          actionPoint.text = "";
          //actionPointListUi.add(atAddActionPointText);
          // callApi();
        }, borderRadius: 20.0),
      ),
    );
  }

  Widget viewHistoryButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget / 2.5,
        height: 40,
        child: PrimaryElevatedBtn(
            color: Palette.backgroundBgFirst,
            textColor: Palette.kColorWhite,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            "VIEW ACTION", () {
          if (controller.actionPointInputList.isNotEmpty) actionPointView();
          /*if(actionPoint.text.isNotEmpty){
                controller.actionPointInputList.add(ActionPointInputModel(
                    policyId: policyId,
                    actionPointText: actionPoint.text,
                    policyStatus: policyTypeValue.value.id,
                    openClosedStatus: actionPointValue.value.id));
              }
          callApi();*/
        }, borderRadius: 20.0),
      ),
    );
  }

  Widget createButton() {

    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: SizedBox(
        width: screenWidget / 2,
        height: 40,
        child: PrimaryElevatedBtn(
            color: Palette.backgroundBgFirst,
            textColor: Palette.kColorWhite,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            "Add Meeting", () {
          if (nextMeetingDate.text.isEmpty) {
            Common.showToast("Please select next meeting date");
            return;
          }
          if (controller.actionPointInputList.isEmpty) {
            Common.showToast("Please add at least one policy");
            return;
          }
          if (reminderMeetingDate.text.isEmpty) {
            Common.showToast("Please add reminder date");
            return;
          }
          if (reminderMeetingTime.text.isEmpty) {
            Common.showToast("Please add reminder time");
            return;
          }
          if (actionPoint.text.isNotEmpty) {
            controller.actionPointInputList.add(ActionPointInputModel(
                policyId: policyId,
                actionPointText: actionPoint.text,
                policyStatus: policyTypeValue.value.id,
                openClosedStatus: actionPointValue.value.id));
          }
          final Event event = Event(
            title: 'Policy Meeting',
            description: '"',
            location: "",
            startDate: DateTime(2023,controller.month,controller.daya,controller.hours,controller.mints),
            endDate: DateTime(2023,controller.month,controller.daya,controller.hours,controller.mints),
            iosParams:  IOSParams(
                reminder: Duration(hours:controller.hours)
            ),
            androidParams: const AndroidParams(
              emailInvites: [], // on Android, you can add invite emails to your event.
            ),
          );
          Add2Calendar.addEvent2Cal(event);
          callApi();

        }, borderRadius: 20.0),
      ),
    );
  }

  Future<void> callApi() async {
    MeetingInputModel data = MeetingInputModel(
        reminderMeetingDate: reminderMeetingDate.text,
        reminderMeetingTime: reminderMeetingTime.text,
        nextMeetingDate: nextMeetingDate.text,
        prospectId: arguments['prospectId'],
        meetingType: selectTypeValue.value.id,
        lastMeetingDate: lastMeetingDate.text,
        contactPerson: controller.personValue.value.id,
        actionPointData: controller.actionPointInputList);
    controller.callCreateMeetingApi(data, contactPersonValue.value.type);
    actionPoint.text = "";
  }

  Widget bottomSheetHeader(double screenWidget) {
    return Text("Action Point",
        textAlign: TextAlign.center,
        style: TextStyles.headingTexStyle(
            color: Palette.appBar,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat'));
  }

  void actionPointView() {
    showModalBottomSheet(
        elevation: 20,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0), topLeft: Radius.circular(15.0)),
            side: BorderSide(color: Colors.white)),
        context: Get.context!,
        builder: (context) => DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.1,
              maxChildSize: 0.7,
              expand: false,
              builder: (_, controller) => SizedBox(
                height: screenHeight / 1.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              bottomSheetHeader(screenWidget),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 1,
                                color: MyColors.themeColor,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0, right: 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: actionPointWidget,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
            ));
  }

  /*(BuildContext c) {
  return SizedBox(
  height: screenHeight / 1.5,
  child: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
  const SizedBox(
  height: 10,
  ),
  bottomSheetHeader(screenWidget),
  const SizedBox(
  height: 10,
  ),
  const Divider(
  height: 1,
  color: MyColors.themeColor,
  ),
  const SizedBox(
  height: 10,
  ),
  Padding(
  padding: const EdgeInsets.only(left: 0, right: 0),
  child: SingleChildScrollView(child: Column(
  children: actionPointWidget,
  ),),
  ),
  ],
  ),
  ),
  );
  });*/
  List<Widget> get actionPointWidget {
    List<Widget> list = [];
    for (int i = 0; i < controller.actionPointInputList.length; i++) {
      list.add(actionItem(i));
    }
    return list;
  }

  Widget actionItem(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Policy Name",
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  controller.policy
                      .lastWhere((element) =>
                          element.id ==
                          controller.actionPointInputList[index].policyId)
                      .type,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Policy Status",
                    style: TextStyles.headingTexStyle(
                      color: Palette.prospectCardTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat',
                    ),
                  ),

                  Text(
                    policyTypeList
                        .lastWhere((element) =>
                            element.id ==
                            controller.actionPointInputList[index].policyStatus)
                        .type,
                    style: TextStyles.headingTexStyle(
                      color: Palette.prospectCardTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  )
                ],
              ),

            InkWell(onTap: (){controller.actionPointInputList.removeAt(index);Get.back();},child: const Icon(Icons.delete_outline_rounded,color: Palette.appColor,),)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: screenWidget/4,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Action Point",
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  ),
                ),

                Text(
                  controller.actionPointInputList[index].actionPointText,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                )
              ],
            ),),
            SizedBox(width: screenWidget/4,child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Action Point Status",
                  textAlign: TextAlign.left,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat',
                  ),
                ),

                Text(
                  actionPointList
                      .lastWhere((element) =>
                  element.id ==
                      controller
                          .actionPointInputList[index].openClosedStatus)
                      .type,
                  style: TextStyles.headingTexStyle(
                    color: Palette.prospectCardTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                )
              ],
            ),),
            const Icon(Icons.delete_outline_rounded,color: Colors.transparent,)

          ],
        ),
        const Divider(
          color: Palette.appColor,
        ),
      ],
    );
  }
}
