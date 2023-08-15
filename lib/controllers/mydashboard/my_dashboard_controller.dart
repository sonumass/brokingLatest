import 'package:get/get.dart';
import '../../data/network/apiservices/my_dashboard_api_service.dart';
import '../../data/preferences/AppPreferences.dart';
import '../../model/mydashboard/my_dashboard_data.dart';
import '../../utils/common_util.dart';
import '../base_getx_controller.dart';

class MyDashboardController extends BaseController {
  final apiServices = Get.put(MyDashboardApiServices());
  final appPreferences = Get.find<AppPreferences>();
  final isLoader=false.obs;
  MyDashboardData ? myDashboardData;

  @override
  void onInit() {
    super.onInit();
    callDashboardApi();
  }

  void callDashboardApi() async {
    isLoader.value=true;
    final response = await apiServices.dashboardApi(
        appPreferences.email, appPreferences.userId);
    isLoader.value=false;
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      if (response.responsedata!=null) {
        myDashboardData=response.responsedata;

      }
    }
  }
}