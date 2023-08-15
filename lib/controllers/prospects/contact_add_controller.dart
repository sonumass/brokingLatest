import 'package:broking/controllers/prospects/prospect_list_controller.dart';
import 'package:broking/data/network/apiservices/prospect_api_service.dart';
import 'package:broking/data/preferences/AppPreferences.dart';
import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/model/prospects/prospectinput/policy_item_input.dart';
import 'package:broking/model/prospects/viewprospects/Contactperson.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/ddd/login_type_data.dart';
import '../../model/prospects/prospectinput/prospect_detail_input.dart';
import '../../utils/common_util.dart';
import '../../utils/permission_file.dart';
import '../base_getx_controller.dart';

class ContactAddController extends BaseController {
  List<ContactItemInput>  contactInputDataList=[];
  List<PolicyItemInput>  policyInputDataList=[];
  final apiServices = Get.find<ProspectApiServices>();
  final appPreferences = Get.find<AppPreferences>();
  String? base64Data="";
  String? fileExt="jpg";
  var selectedDate = DateTime.now().obs;
  RxList<PlatformFile>  platformFile=<PlatformFile>[].obs;

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
  RxList<LoginTypeData> industriesTypeList = [ LoginTypeData(id: "1",type:"IT" ),
    LoginTypeData(id: "2",type:"Services" ),
    LoginTypeData(id: "3",type:"Aviation" ),
    LoginTypeData(id: "4",type:"Manufacturing" ),
    LoginTypeData(id: "5",type:"Manufacturing-Power" ),
    LoginTypeData(id: "6",type:"Manufacturing-Steel" ),
    LoginTypeData(id: "7",type:"Manufacturing-Petro-Chemicals" ),
    LoginTypeData(id: "8",type:"Manufacturing-Sugar" ),
    LoginTypeData(id: "9",type:"Manufacturing-Construction" ),
    LoginTypeData(id: "10",type:"Manufacturing-Chemicals" ),
    LoginTypeData(id: "11",type:"Manufacturing-Paper" ),
    LoginTypeData(id: "12",type:"Manufacturing-FMCG" ),
    LoginTypeData(id: "13",type:"Other" ),].obs;
  RxList<LoginTypeData> verticalList = [ LoginTypeData(id: "1",type:"Corporate" ),
    LoginTypeData(id: "2",type:"SME" ),
    LoginTypeData(id: "3",type:"Retail" ),
    LoginTypeData(id: "4",type:"Government" ),
    LoginTypeData(id: "5",type:"Aviation" ),].obs;
  final loginType="0".obs;
  final isLoader = false.obs;
  late final Rx<LoginTypeData> selectTypeValue = industriesTypeList.first.obs;
  RxList<LoginTypeData>  premiumPotential=<LoginTypeData>[].obs;
  RxList<LoginTypeData>  industryType=<LoginTypeData>[].obs;
  RxList<LoginTypeData>  vertical=<LoginTypeData>[].obs;
  RxList<LoginTypeData>  policyType=<LoginTypeData>[].obs;
  late final Rx<LoginTypeData> verticalListValue = vertical.first.obs;
  late final Rx<LoginTypeData> industryTypeValue = industryType.first.obs;
  late final Rx<LoginTypeData> policyTypeValue = policyType.first.obs;
  late final Rx<LoginTypeData> premiumPotentialValue = premiumPotential.first.obs;
  @override
  void onInit() {
    super.onInit();
  }
  void callProspectDataApi() async {
    isLoader.value=true;
    final response = await apiServices.prospectData(appPreferences.email);
    isLoader.value=false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      premiumPotential.value=response.responsedata?.premiumPotential ?? [];
      industryType.value=response.responsedata?.industryType ?? [];
      vertical.value=response.responsedata?.vertical ?? [];
      policyType.value=response.responsedata?.policyType ?? [];
    }

  }
  void createProspectApi({prospectId,email,phone,type}) async {
    showLoader();
    final response = await apiServices.addProspectApi(prospectDetailInput,contactInputDataList,policyInputDataList);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    Common.showToast(response!=null?response.message:"Something went wrong!");

  }
  void addContact({name,email,designation,location,decisionMaker,phone1,phone2,birthday,anniversary}){
    contactInputDataList.add(ContactItemInput(contactpersonid: "", prospectid: "", personname: name, designation: designation, personlocation: location, email: email, phone: phone1, decesionmaker: decisionMaker, phone2: phone2, birthday: birthday, anniversary: anniversary));
  }
  void addPolicy({renewalDate,suminsured,premium,policyName,uploadDoc,remarks,fileExt}){
    policyInputDataList.add(PolicyItemInput(renewalDate: renewalDate, suminsured: suminsured, premium: premium, policyName: policyName, uploadDoc: uploadDoc,remarks:remarks ,fileExt:fileExt));
  }
  void addProspectDetail({
    id="",
    prospectName,
    totalMeeting,
    adddress,
    state,
    pinCode,
    cityName,
    industryType,
    turnover,
    parentCompany,
    premiumClosed,
    corporateOffice,
    premiumPotential,
    premiumAchieved,
    vertical,
    writeUp,
    referee,}){

    prospectDetailInput=ProspectDetailInput(id:"",
      email:appPreferences.email,
      userId:appPreferences.userId,
      officeId:appPreferences.officeId,
      prospectName:prospectName,
      totalMeeting:totalMeeting,
      adddress:adddress,
      state:state,
      pinCode:pinCode,
      cityName:cityName,
      industryType:industryType,
      turnover:turnover,
      parentCompany:parentCompany,
      premiumClosed:premiumClosed,
      corporateOffice:corporateOffice,
      premiumPotential:premiumPotential,
      premiumAchieved:premiumAchieved,
      vertical:vertical,
      writeUp:writeUp,
      referee:referee,
      );

  }
  void selectedFile() async {
    var statusStorage = await Permission.storage.status;
    if (statusStorage.isGranted) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpg', 'pdf', 'doc','jpeg', ],
        );
        if (result != null) {
          platformFile.clear();
          //List<PlatformFile> file = result.files;
          PlatformFile file = result.files.first;
          platformFile.add(file);
          fileExt=file.extension;
          base64Data=Common.readByteConvertBase64(file.path??"")??"";
        } else {
          Common.showToast("You need to add this permission for share policy file");
          // User canceled the picker
        }
      } on PlatformException catch (e) {
        Common.showToast('Failed to pick image: $e');
      }
    } else {
      if (await requestPermission(Permission.storage, 'Storage') == false) {
        try {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: false,
            allowedExtensions: ['jpg', 'pdf', 'doc'],
          );
          if (result != null) {
            //List<PlatformFile> file = result.files;
            PlatformFile file = result.files.first;
            base64Data=Common.readByteConvertBase64(file.path??"")??"";
            Common.showToast("You need to add this permission for share policy file");
          } else {
            Common.showToast("You need to add this permission for share policy file");
            // User canceled the picker
          }
        } on PlatformException catch (e) {
          Common.showToast('Failed to pick image: $e');
        }
        return;
      }
      try {

      } on PlatformException catch (e) {
        Common.showToast('Failed to pick image: $e');
      }

    }
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
}
/*
*/