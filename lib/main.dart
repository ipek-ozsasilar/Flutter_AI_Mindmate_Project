import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/login/create_account_view.dart';
import 'package:flutter_mindmate_project/features/profile/profile_view.dart';
import 'package:flutter_mindmate_project/features/splash/splash_view.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/device_type_enum.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/initiliazer/app_initiliazer.dart';
import 'package:flutter_mindmate_project/service_locator/service_locator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_mindmate_project/features/login/log_in_view.dart';
import 'package:flutter_mindmate_project/features/create_chat/create_chat_view.dart';
import 'package:flutter_mindmate_project/features/message/message_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  //AppInitiliazer'ı başlatır
  //AppInitiliazer'ın init metodu async olduğu için await kullanıyoruz.
  await AppInitiliazer().init();
  //MyApp widget'ını ProviderScope ile sarmalıyoruz (Riverpod için gerekli)
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        //breakpoints → belirli ekran genişliklerinde widget’ların nasıl ölçekleneceğini veya yeniden boyutlanacağını tanımlar.
        breakpoints: [
          Breakpoint(
            start: ScreenSizesEnum.mobileSmall.value,
            end: ScreenSizesEnum.mobileLarge.value,
            name: DeviceTypeEnum.mobile.value,
          ),
          Breakpoint(
            start: ScreenSizesEnum.tabletSmall.value,
            end: ScreenSizesEnum.tabletLarge.value,
            name: DeviceTypeEnum.tablet.value,
          ),
          Breakpoint(
            start: ScreenSizesEnum.desktopSmall.value,
            end: ScreenSizesEnum.desktopLarge.value,
            name: DeviceTypeEnum.desktop.value,
          ),
          Breakpoint(
            start: ScreenSizesEnum.xlLarge.value,
            end: double.infinity,
            name: DeviceTypeEnum.xl.value,
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mindmate App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: Colors.transparent,
            iconSize: IconSizesEnum.iconSize.value,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: ColorName.scaffoldBackgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorName.yellowColor,
            foregroundColor: ColorName.blackColor,
            shape: RoundedRectangleBorder(),
          ),
        ),
      ),
      home: SplashView(),
    );
  }
}
