import 'package:flutter/material.dart';
import 'package:flutter_mindmate_project/features/splash/splash_view.dart';
import 'package:flutter_mindmate_project/gen/colors.gen.dart';
import 'package:flutter_mindmate_project/products/enums/device_type_enum.dart';
import 'package:flutter_mindmate_project/products/enums/sizes_enum.dart';
import 'package:flutter_mindmate_project/products/initiliazer/app_initiliazer.dart';
import 'package:flutter_mindmate_project/products/navigation/app_navigator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  //AppInitiliazer'ı başlatır
  //AppInitiliazer'ın init metodu async olduğu için await kullanıyoruz.
  await AppInitiliazer().init();
  //MyApp widget'ını ProviderScope ile sarmalıyoruz (Riverpod için gerekli)
  //dotenv.load(fileName: ".env"); ile .env dosyasını yükler
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //GlobalKey<NavigatorState> türünde global bir anahtar. Uygulamanın Navigator durumuna, herhangi bir yerden (BuildContext olmadan) erişmenizi sağlar.
      //navigatorKey.currentState ile push/pop yaparak ekrana yönlendirme, dialog açma gibi işlemleri UI context’i olmayan kodlardan (ör. servisler,
      //background callback’ler) gerçekleştirebilirsiniz. Notification ile alakası ne? Bildirim tıklanınca veya mesajdan
      //uygulama açılınca çoğu zaman bir ekrana yönlendirmek gerekir. Bu callback’lerde genelde BuildContext yoktur. 
      //navigatorKey sayesinde: bildirimden gelen veriye göre ilgili sayfaya güvenle yönlendirme yapılır.
      navigatorKey: navigatorKey,
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
