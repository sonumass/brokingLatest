import 'dart:core';
import 'package:broking/model/ddd/city_data.dart';
import 'package:get/get.dart';
import '../../utils/common_util.dart';
import '../data/network/apiservices/location_api_service.dart';
import '../model/ddd/state_data.dart';
import 'base_getx_controller.dart';
class LocationController extends BaseController {
  final apiServices = Get.put(LocationApiServices());
  RxList<StateData> stateList=<StateData>[].obs;
  RxList<CityData> cityList=<CityData>[].obs;
  late final Rx<StateData> stateValue = stateList.first.obs;

  @override
  void onInit() {
    super.onInit();
    callLocation();
  }

  void callLocation() async {
    final response = await apiServices.getLocation();
    if (response == null) Common.showToast("Server Error!");
    if (response != null && response.status == "200") {
      if (response.responsedata!.state.isNotEmpty) {
        stateList.value=response.responsedata!.state;
      }
      if (response.responsedata!.city.isNotEmpty) {
        cityList.value=response.responsedata!.city;
      }
    }
  }
  List<CityData>? city(String idValue){
    List<CityData>? list=<CityData>[].obs;
    list.add(CityData(id: "0", stateId: "0", cityName: "Select City"));
    for( int a=0;a<cityList.length-1;a++){
      if(cityList[a].stateId == idValue){
        list.add(cityList[a]);
      }
    }
    return list;

  }
}