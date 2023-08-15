import 'dart:math';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:broking/controllers/reminder/alarm_controller.dart';
import 'package:broking/model/ddd/login_type_data.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/network/apiservices/meeting_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../model/ddd/policy_type_data.dart';
import '../../model/meeting/cretaemeeting/Meetings.dart';
import '../../model/meeting/meeting_input_type.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class MeetingCreateController extends BaseController {
  final apiServices = Get.put(MeetingApiServices());
  final appPreferences = Get.find<AppPreferences>();
  var selectedDate = DateTime.now().obs;
  var reminderDate = DateTime.now().obs;
  String? selectedGender;
  final selectedActionPoint = true.obs;
   int daya=0;
  int month=1;
  int hours = 0;
  int mints=12;
  List<ActionPointInputModel> actionPointInputList = [];
  final List<String> gender = ["Male", "Female"];

  String? select;

  List<Meetings> meetings = [];
  RxList<PolicyTypeData> policy = <PolicyTypeData>[].obs;
  RxList<LoginTypeData> contactPerson = <LoginTypeData>[].obs;
  RxList<LoginTypeData> personList = <LoginTypeData>[].obs;
  late final Rx<LoginTypeData> personValue = personList.first.obs;

  //late final Rx<LoginTypeData> policyValue = policy.first.obs;
  List<String> policyStr = [];
  final selectedPolicy = false.obs;
  final loginType = "0".obs;
  final isLoader = false.obs;
  Position? position;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void onClickRadioButton(value) {
    print(value);
    select = value;
    update();
  }

  void getMeetingDataApi(String prospectId) async {
    isLoader.value = true;
    try {
      final response = await apiServices.getMeetingDataApi(
          appPreferences.email, prospectId, appPreferences.userId);
      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.responsedata != null) {
          meetings = response.responsedata!.meetings;
          personList.value = response.responsedata!.contactPerson;
          // policy.value = response.responsedata!.policy;
          if (response.responsedata!.policy.isNotEmpty) {
            for (var element in response.responsedata!.policy) {
              policy.add(PolicyTypeData(
                  id: element.id, type: element.type, isCheck: false.obs));
            }
          }
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void callCreateMeetingApi(
      MeetingInputModel data,String contactPerson) async {
    showLoader();
    try {

      Position position = await Geolocator.getCurrentPosition();
      final response = await apiServices.createMeetingApi(data,appPreferences.userId,
          latitude: position.latitude,
          longitude: position.longitude);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        actionPointInputList.clear();
        //DateTime tempDate =  DateFormat("dd-MMM-yyyy hh:mm aa").parse("${data.reminderMeetingDate} ${data.reminderMeetingTime}");
        //_showNotification(contactPerson,tempDate);
        try{
          final controller = Get.find<AlarmController>();
          controller.callAlarmApi();
        }catch(e){
          debugPrint(e.toString());
        }

        Common.showToast(response?.message ?? "Something went wrong!");
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  void selectDate(TextEditingController textController, {type}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      if (type == "nextMeetingDate") {
        //_scheduleOneShotAlarm(pickedDate);
      }

      textController.text = DateFormat("dd-MMM-yyyy").format(pickedDate);
    }
  }
  void reminderSelectDate(TextEditingController textController, {type}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: reminderDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != reminderDate.value) {
      reminderDate.value = pickedDate;
      if (type == "nextMeetingDate") {
        //_scheduleOneShotAlarm(pickedDate);
      }
       daya=pickedDate.day;
       month=pickedDate.month;

      textController.text = DateFormat("dd-MMM-yyyy").format(pickedDate);
    }
  }

  Future<Position> getGeoLocationPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    } else {
      throw Exception(e);
    }
    return await Geolocator.getCurrentPosition();
  }

  void _oneShotAtTaskCallback() {
    if (kDebugMode) {
      print("One Shot At Task Running");
    }
  }

  void scheduleOneShotAlarm(DateTime dateTime) async {
    const int oneShotAtTaskId = 2;

    DateTime chosenDate = dateTime;
    await AndroidAlarmManager.oneShotAt(
        chosenDate, oneShotAtTaskId, _oneShotAtTaskCallback);
  }
  Future<void> _showNotification(String person,DateTime dt) async {
    tz.TZDateTime.from(dt, tz.local);
    final  dateTime=tz.TZDateTime.from(dt, tz.local);
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        icon: "@mipmap/ic_launcher",
        priority: Priority.high,
        
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.zonedSchedule(Random().nextInt(1000), "Prospect meeting", "Your meeting set with $person",dateTime , notificationDetails, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime, androidAllowWhileIdle: true);
    /*await flutterLocalNotificationsPlugin.show(
        090, 'plain title', 'plain body', notificationDetails,
        payload: 'item x');*/
  }
}
