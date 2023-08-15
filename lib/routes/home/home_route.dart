import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../ui/module/dashboard/dashboard_page.dart';
import '../../ui/module/dashboard/my_dashboard.dart';

class HomeRoutes {
  HomeRoutes._();

  static List<GetPage> get routes => [
        GetPage(name: DashboardPage.routeName, page: () => DashboardPage()),
        GetPage(name: MyHomeDashboardPage.routeName, page: () => MyHomeDashboardPage()),
        ];
}
