import 'package:broking/routes/home/home_route.dart';
import 'package:broking/routes/login/login.dart';
import 'package:broking/routes/meeting/meeting.dart';
import 'package:broking/routes/prospect/prospects.dart';
import 'package:broking/routes/reminder/reminder.dart';
import 'package:broking/routes/splash_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
class Routes {
  Routes._();

  static List<GetPage> get() {
    final moduleRoutes = <GetPage>[];
    moduleRoutes.addAll(SplashScreenRoutes.routes);
    moduleRoutes.addAll(LoginRoutes.routes);
    moduleRoutes.addAll(HomeRoutes.routes);
    moduleRoutes.addAll(ProspectRoutes.routes);
    moduleRoutes.addAll(MeetingRoutes.routes);
    moduleRoutes.addAll(ReminderRoutes.routes);

    return moduleRoutes;
  }
}
