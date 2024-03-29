import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/ad_dashboard.dart';
import 'package:rainbow_new/screens/auth/auth_dashboard/auth_dashboard.dart';
import 'package:rainbow_new/screens/auth/register/widget/RegisterVerifyOtp_Screen.dart';
import 'package:rainbow_new/screens/dashboard/dash_board.dart';
import 'package:rainbow_new/screens/scanyour_face/scanyourface_controller.dart';
import 'package:rainbow_new/screens/splash/splash_screen.dart';
import 'package:rainbow_new/screens/terms_conditions/terms_conditions_screen.dart';
import 'package:rainbow_new/service/notification_service.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/pref_keys.dart';
import 'screens/auth/register/widget/registerVerify_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
/*  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAHDoEBaS6zAHsNvEIvUnQI42mP6_rF10s',
        authDomain: '',
        databaseURL: '',
        projectId: 'rainbow-99314',
        storageBucket: '',
        messagingSenderId: '115304537008',
        appId: '1:115304537008:android:b1eb09b75b877ed5789475',
        measurementId: '',
      ),
    );
  } else if (Platform.isIOS) {
    await Firebase.initializeApp();
  }*/
  NotificationService.init();
  await FirebaseMessaging.instance.getToken().then((value) {
    if (kDebugMode) {
      print("FCM Token Token Token Token => $value");
    }
    print("FCM Token Token Token Token => $value");

  });
  await PrefService.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Color(0xff50369C), //or set color with: Color(0xFF0000FF)
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanYourFaceController scanYourFaceController =
        Get.put(ScanYourFaceController());
    return GetMaterialApp(
      title: 'Rainbow Surrogacy',
      theme: ThemeData(
        primaryColor: ColorRes.themeColor,
        colorScheme: const ColorScheme.dark().copyWith(
          primary: ColorRes.themeColor,
          secondary: ColorRes.themeColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/RegisterOtpScreen",
          page: () => const RegisterOtpScreen(),
          binding: BindingsBuilder(
            () => RegisterVerifyController(),
          ),
        ),
      ],
      // home: ScanYourFaceScreen(),
      home: /*const GoogleMapScreen()*/ /*SupportDetailsScreen(com: "")*/ !PrefService
              .getBool(PrefKeys.skipBoardingScreen)
          ? SplashScreen()
          : PrefService.getBool(PrefKeys.isLogin)
              ? PrefService.getBool(PrefKeys.showTermsCondition)
                  ? TermsConditionsScreen(showBackBtn: false)
                  : PrefService.getString(PrefKeys.loginRole) == "end_user"
                      ? const Dashboard()
                      : PrefService.getString(PrefKeys.loginRole) ==
                              "advertisers"
                          ? AdvertisementDashBord()
                          : PrefService.getBool(PrefKeys.isLogin)
                              ? const Dashboard()
                              : AuthDashboard()
              : AuthDashboard(),
    );
  }
}
