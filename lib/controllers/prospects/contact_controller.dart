import 'package:broking/controllers/prospects/prospect_detail_controller.dart';
import 'package:broking/controllers/prospects/prospect_list_controller.dart';
import 'package:broking/data/network/apiservices/prospect_api_service.dart';
import 'package:broking/model/prospects/prospectinput/contect_person_item_input.dart';
import 'package:broking/model/prospects/prospectinput/policy_item_input.dart';
import 'package:broking/model/prospects/prospectinput/prospect_detail_input.dart';
import 'package:broking/model/prospects/viewprospects/Responsedata.dart';
import 'package:get/get.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class ContactController extends BaseController {

  final loginType="0".obs;
  final isLoader = false.obs;
  final listController=Get.find<ProspectListController>();
  final controllerProspectDetail = Get.put(ProspectDetailCardController());
  final apiServices = Get.find<ProspectApiServices>();
  final appPreferences = Get.find<AppPreferences>();
  final state="".obs;
  final city="".obs;
  final country="".obs;
  @override
  void onInit() {
    super.onInit();

  }
  void editProspect(ProspectViewData prospectViewData) async {
    List<ContactItemInput>  contactInputDataList=[];
    List<PolicyItemInput>  policyInputDataList=[];
    for(int i=0;i<prospectViewData.contactperson.length;i++){
      contactInputDataList.add(ContactItemInput(contactpersonid: prospectViewData.contactperson[i].contactPersonId, prospectid: prospectViewData.contactperson[i].prospectId, personname: prospectViewData.contactperson[i].personName, designation: prospectViewData.contactperson[i].designation, personlocation: prospectViewData.contactperson[i].personLocation, email: prospectViewData.contactperson[i].email, phone: prospectViewData.contactperson[i].phone, decesionmaker: prospectViewData.contactperson[i].decesionMaker, phone2: prospectViewData.contactperson[i].phone2??"", birthday: prospectViewData.contactperson[i].birthday??"", anniversary: prospectViewData.contactperson[i].anniversary??""));
    }
    for(int i=0;i<prospectViewData.policies.length;i++){
      policyInputDataList.add(PolicyItemInput(renewalDate: prospectViewData.policies[i].renewalDate, suminsured: prospectViewData.policies[i].sumInsured, premium: prospectViewData.policies[i].premiumPotential, policyName: prospectViewData.policies[i].policyType, remarks: "", uploadDoc: prospectViewData.policies[i].policyFile));
    }
    ProspectDetailInput prospectDetailInput=ProspectDetailInput(id: prospectViewData.prospectDetails?.prospectId??"", email:appPreferences.email, userId: appPreferences.userId, officeId: appPreferences.officeId, prospectName: prospectViewData.prospectDetails?.prospectName??"", totalMeeting: prospectViewData.prospectDetails?.totalMeeting??"", adddress: prospectViewData.prospectDetails?.adddress??"", state: "N/A", pinCode: prospectViewData.prospectDetails?.pinCode??"", cityName: prospectViewData.prospectDetails?.cityName??"", industryType: prospectViewData.prospectDetails?.industryType??"", turnover: prospectViewData.prospectDetails?.turnover??"", parentCompany: prospectViewData.prospectDetails?.parentCompany??"", premiumClosed: prospectViewData.prospectDetails?.premiumClosed??"", corporateOffice: prospectViewData.prospectDetails?.corporateOffice??"", premiumPotential: prospectViewData.prospectDetails?.premiumPotential??"", premiumAchieved: prospectViewData.prospectDetails?.premiumAchived??"", vertical: "", writeUp: prospectViewData.prospectDetails?.writeupNotes??"", referee: prospectViewData.prospectDetails?.referee??"");
    showLoader();
    final response = await apiServices.editProspectApi(prospectDetailInput,contactInputDataList,policyInputDataList);
    hideLoader();
    if (response == null) Common.showToast("Server Error!");
    Common.showToast(response!=null?response.message:"Something went wrong!");

  }

}