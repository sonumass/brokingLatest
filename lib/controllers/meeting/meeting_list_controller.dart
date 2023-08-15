import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../data/network/apiservices/meeting_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../model/meeting/MeetingData.dart';
import '../../model/meeting/meetingList/MeetingDataList.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class MeetingController extends BaseController {
  final apiServices = Get.put(MeetingApiServices());
  final appPreferences = Get.find<AppPreferences>();
  var selectedDate = DateTime.now().obs;
  String? selectedGender;
  final selectedActionPoint = true.obs;

  final List<String> gender = ["Male", "Female"];

  String? select;
  List<MeetingDataList> dataMeetingList = [];
  RxList<MeetingDataList> meetingList = <MeetingDataList>[].obs;
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

  void callMeetingApi(String type,String prospectId) async {
    isLoader.value = true;
    try {
      final response = await apiServices.meetingListApi(
          appPreferences.email, appPreferences.userId, type,prospectId:prospectId);
      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.responsedata.isNotEmpty) {

          dataMeetingList = response.responsedata;
          meetingList.value = response.responsedata;
        }else{
          dataMeetingList.clear();
          meetingList.clear();
        }
      } else {
        Common.showToast(response?.message ?? "Something went wrong!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void filterSearchResults(String query, String type) {
    if (query.isNotEmpty) {
      List<MeetingDataList> dataList = [];
      for (var element in dataMeetingList) {
        if (element.prospectName.toLowerCase().contains(query)) {
          dataList.add(element);
        }
      }
      if (dataList.isNotEmpty) {
        meetingList.clear();
        meetingList.value = dataList;
      }
    } else {
      meetingList.clear();
      searchMeetingApi(type);
    }
  }

  void searchMeetingApi(String type) async {
    showLoader();
    try {
      final response = await apiServices.meetingListApi(
          appPreferences.email, appPreferences.userId, type);
      hideLoader();
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.responsedata.isNotEmpty) {
          meetingList.value = response.responsedata;
        }
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
}
