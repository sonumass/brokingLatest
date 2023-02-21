import 'package:get/get.dart';

import '../../ui/module/login/forgot_password_page.dart';
import '../../ui/module/login/login_page.dart';
import '../../ui/module/login/set_password_page.dart';

class LoginRoutes {
  LoginRoutes._();

  static List<GetPage> get routes => [
    GetPage(name: LoginPage.routeName, page: () => LoginPage()),
    GetPage(name: ForgotPasswordPage.routeName, page: () => ForgotPasswordPage()),
    GetPage(name: ChangePasswordPage.routeName, page: () => ChangePasswordPage()),

       /* GetPage(name: LoginPage.routeName, page: () => LoginPage()),
        GetPage(name: BeforLoginPage.routeName, page: () => BeforLoginPage()),
        GetPage(name: OtpPage.routeName, page: () => OtpPage()),*/
        /* GetPage(name: Register.routeName, page: () =>  Register()),
    GetPage(name: Otp.routeName, page: () =>  Otp()),*/
      ];
}
