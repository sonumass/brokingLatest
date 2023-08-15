import 'package:broking/data/network/apiservices/prospect_api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../model/prospects/prospectinput/contect_person_item_input.dart';
import '../../model/prospects/prospectinput/policy_item_input.dart';
import '../../model/prospects/prospectinput/prospect_detail_input.dart';
import '../../model/prospects/viewprospects/Responsedata.dart';
import '../../model/reminder/Reminder_count_model.dart';
import '../../model/reminder/Responsedata.dart';
import '../../model/reminder/detailList/ReminderDataList.dart';
import '../../model/reminder/detailList/response_data_List.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ReminderListController extends BaseController {
  final apiServices = Get.put(ProspectApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final searchViewController = TextEditingController();
  RxList<ReminderDataList> reminderDetailList=<ReminderDataList>[].obs;
  RxList<ReminderDataList> dataList=<ReminderDataList>[].obs;

  ReminderCount? reminderCount;
  final isLoader = false.obs;
  final isDetailLoader = false.obs;
  @override
  void onInit() {
    super.onInit();
    callReminderApi();
  }
  void callReminderApi({type}) async {
    isLoader.value=true;
    final response = await apiServices.reminderCount(appPreferences.email,appPreferences.userId);
    isLoader.value=false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        reminderCount=response.responsedata;
      }

  }
  void reminderListApi({reminderType}) async {
    isDetailLoader.value=true;
    final response = await apiServices.reminderDetailList(appPreferences.email,appPreferences.userId,reminderType);
    isDetailLoader.value=false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      reminderDetailList.value=response.responsedata;

      /*if(prospectViewData[0].prospectDetails!=null){
          final inputData=prospectViewData[0].prospectDetails;
          prospectDetailInput=ProspectDetailInput(id: inputData?.prospectId??"", email: "", userId: "", officeId: "", prospectName: inputData.prospectName, totalMeeting: totalMeeting, adddress: adddress, state: state, pinCode: pinCode, cityName: cityName, industryType: industryType, turnover: turnover, parentCompany: parentCompany, premiumClosed: premiumClosed, corporateOffice: corporateOffice, premiumPotential: premiumPotential, premiumAchieved: premiumAchieved, vertical: vertical, writeUp: writeUp, referee: referee)
        }*/
    }

  }
  Future<void> filterSearchResults(String query,String type) async{
   /* List<ReminderDataList> dummySearchList = <ReminderDataList>[];
    dummySearchList.addAll(reminderDetailList);
    dataList.clear();
    if(query.isNotEmpty) {
      List<ReminderDataList> dummySearchListt = <ReminderDataList>[];
      for (var item in dummySearchList) {
        String searchItem=item.data.??"";
        if(searchItem.toLowerCase().contains(query)) {
          dummySearchListt.add(item);
        }
      }
      if(dummySearchListt.isEmpty){
        dataList.addAll(dummySearchList);
        return;
      }
      dataList.addAll(dummySearchListt);
      return;
    } else {
      await callProspectListSearchApi(type);
      dataList.addAll(reminderDetailList);
    }*/
  }
  Future<void> callProspectListSearchApi(String reminderType) async {
    reminderDetailList.clear();
    showLoader();
    final response = await apiServices.reminderDetailList(
        appPreferences.email, appPreferences.userId, reminderType);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      reminderDetailList.value=response.responsedata;

    }
  }

}
