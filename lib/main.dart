import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utilities/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonData = prefs.getString('userrecord') ?? '';
  bool isLogin = jsonData.isNotEmpty;
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  Stripe.publishableKey = 'pk_test_51RmFfq4IO36cFGKwk9ot8KdbYWbGFhFq44wdli1fsMa8WExt27DQrCBr2WNDe2wTOwMKX91NYBkW4utUl3oN2ea600R3DNYS0F';
  await Stripe.instance.applySettings();
  String initialRoute;
  if (isFirstTime) {
    initialRoute = '/onboarding';
    prefs.setBool('isFirstTime', false);
  } else if (isLogin) {
    initialRoute = '/bottom-nav';
  } else {
    initialRoute = '/login';
  }
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Buyzaars",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      theme: ThemeData(
        appBarTheme:
            AppBarTheme(iconTheme: IconThemeData(color: AppColor.white)),
        primaryColor: AppColor.primarycolor,
        textTheme: GoogleFonts.interTextTheme(
          Get.theme.textTheme
              .apply(bodyColor: AppColor.white, displayColor: AppColor.white),
        ),
      ),
    ),
  );
}

// storePassword=buyzaarsapp
// keyPassword=buyzaarsapp
// keyAlias=upload
// storeFile=../app/upload-keystore.jks