import 'package:broking/model/meeting/Meeting_prospect.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/network/apiservices/meeting_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class MeetingProspectController extends BaseController {
  final apiServices = Get.put(MeetingApiServices());
  final appPreferences = Get.find<AppPreferences>();
  var dataList = <MeetingProspect>[];
  RxList<MeetingProspect> meetingList = <MeetingProspect>[].obs;
  final isLoader = false.obs;
  void callMeetingProspectApi() async {
    isLoader.value = true;
    try {
      final response = await apiServices.meetingProspect(
          appPreferences.email, appPreferences.userId, appPreferences.officeId);
      isLoader.value = false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        if (response.responsedata.isNotEmpty) {
          dataList.addAll(response.responsedata);
          meetingList.value = response.responsedata;
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
      List<MeetingProspect> data = [];
      for (var element in dataList) {
        if (element.prospectName!.toLowerCase().contains(query)) {
          data.add(element);
        }
      }
      if(data.isNotEmpty){
        meetingList.clear();
        meetingList.addAll(data.cast<MeetingProspect>());
      }
    }else{
      meetingList.clear();
      meetingList.addAll(dataList);
    }
  }


}
