import 'package:broking/data/network/apiservices/prospect_api_service.dart';
import 'package:broking/model/ddd/login_type_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../model/prospects/prospectinput/contect_person_item_input.dart';
import '../../model/prospects/prospectinput/policy_item_input.dart';
import '../../model/prospects/prospectinput/prospect_detail_input.dart';
import '../../model/prospects/viewprospects/Responsedata.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ProspectListController extends BaseController {
  final apiServices = Get.put(ProspectApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final searchViewController = TextEditingController();
  List<ContactItemInput>  contactInputDataList=[];
  List<PolicyItemInput>  policyInputDataList=[];

  late ProspectDetailInput prospectDetailInput=ProspectDetailInput(id:"",
    email:"",
    userId:"",
    officeId:"",
    prospectName:"",
    totalMeeting:"",
    adddress:"",
    state:"",
    pinCode:"",
    cityName:"",
    industryType:"",
    turnover:"",
    parentCompany:"",
    premiumClosed:"",
    corporateOffice:"",
    premiumPotential:"",
    premiumAchieved:"",
    vertical:"",
    writeUp:"",
    referee:"",);
  RxList<ProspectViewData> prospectViewDataa=<ProspectViewData>[].obs;
  RxList<ProspectViewData> dataList=<ProspectViewData>[].obs;
  final loginType="0".obs;
  final isLoader = false.obs;
  final isDataLoader = false.obs;
  @override
  void onInit() {
    super.onInit();
    callProspectListApi();
  }

  void callProspectListApi({type}) async {
    isLoader.value=true;
    final response = await apiServices.prospectListApi(appPreferences.email,appPreferences.userId,appPreferences.officeId);
    isLoader.value=false;
      if (response == null) Common.showToast("Server Error!");
      if (response != null && response.status == "200") {
        prospectViewDataa.value=response.responsedata;
        dataList.value=response.responsedata;
        prospectViewDataa[0].contactperson.map((e) => contactInputDataList.add(ContactItemInput(contactpersonid: e.contactPersonId, prospectid: e.prospectId, personname: e.personName, designation: e.designation, personlocation: e.personLocation, email: e.email, phone: e.phone, decesionmaker: e.decesionMaker, phone2: e.phone2??"", birthday: e.birthday??"", anniversary: e.anniversary??"")));
        prospectViewDataa[0].policies.map((e) => policyInputDataList.add(PolicyItemInput(renewalDate: e.renewalDate, suminsured: e.sumInsured, premium: e.premiumPotential, policyName: e.policyType, remarks: "", uploadDoc: e.policyFile)));
        /*if(prospectViewData[0].prospectDetails!=null){
          final inputData=prospectViewData[0].prospectDetails;
          prospectDetailInput=ProspectDetailInput(id: inputData?.prospectId??"", email: "", userId: "", officeId: "", prospectName: inputData.prospectName, totalMeeting: totalMeeting, adddress: adddress, state: state, pinCode: pinCode, cityName: cityName, industryType: industryType, turnover: turnover, parentCompany: parentCompany, premiumClosed: premiumClosed, corporateOffice: corporateOffice, premiumPotential: premiumPotential, premiumAchieved: premiumAchieved, vertical: vertical, writeUp: writeUp, referee: referee)
        }*/
      }

  }
  Future<void> filterSearchResults(String query) async{
    List<ProspectViewData> dummySearchList = <ProspectViewData>[];
    dummySearchList.addAll(prospectViewDataa);
    dataList.clear();
    if(query.isNotEmpty) {
      List<ProspectViewData> dummySearchListt = <ProspectViewData>[];
      for (var item in dummySearchList) {
        String searchItem=item.prospectDetails?.prospectName??"";
        String cityName=item.prospectDetails?.cityName??"";
        String premiumPotential=item.prospectDetails?.premiumPotential??"";
        if(searchItem.toLowerCase().contains(query) || cityName.toLowerCase().contains(query) || premiumPotential.toLowerCase().contains(query)) {
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
     await callProspectListSearchApi();
      dataList.addAll(prospectViewDataa);
    }
  }
  Future<void> callProspectListSearchApi() async {
    prospectViewDataa.clear();
    showLoader();
    final response = await apiServices.prospectListApi(
        appPreferences.email, appPreferences.userId, appPreferences.officeId);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      prospectViewDataa.value=response.responsedata;

    }
  }
}