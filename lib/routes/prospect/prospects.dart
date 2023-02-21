import 'package:broking/ui/module/prospects/prospect_list.dart';
import 'package:get/get.dart';

class LoginRoutes {
  LoginRoutes._();

  static List<GetPage> get routes => [
    GetPage(name: ProspectsListPage.routeName, page: () => ProspectsListPage()),
   ];
}
