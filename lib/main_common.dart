import 'package:broking/route.dart';
import 'package:broking/theme/my_theme.dart';
import 'package:broking/ui/splash/splash_screen.dart';
import 'package:broking/utils/translater.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:broking/environment.dart';
import 'package:get/get.dart';
import 'controllers/bindings/initial_binding.dart';
import 'data/mapper/mapper.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  MapperFactory.initialize();
  await Environment.initialize(env);
  debugPrint("MainCommon Env $env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await InitialBindings().dependencies();

  runApp(getMaterialApp);
}

GetMaterialApp get getMaterialApp => GetMaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [],
      translations: TranslateData(),
      locale: const Locale(
        'en',
        'US',
      ),
      fallbackLocale:
          const Locale.fromSubtags(languageCode: 'en', countryCode: ' US'),
      theme: ThemeData(
        primarySwatch: MyColors.appColor,
        fontFamily: "Encode Sans",
      ),
      getPages: Routes.get(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child ?? Container(),
        );
      },
      defaultTransition: Transition.rightToLeftWithFade,
      initialRoute: SplashScreen.routeName,
    );
