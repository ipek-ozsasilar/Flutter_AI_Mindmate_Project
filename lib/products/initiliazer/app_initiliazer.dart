//material
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebaseUI;
//firebase options
import 'package:flutter_mindmate_project/firebase_options.dart';
//service locator
import 'package:flutter_mindmate_project/service_locator/service_locator.dart';
// timezone
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz_loc;

//Kodun amacı: Uygulama başlamadan önce tüm temel servisleri başlatmak.
class AppInitiliazer {
  AppInitiliazer();
  final String localLocation = 'Europe/Istanbul';

  Future<void> init() async {
    //Flutter uygulaması ile platform (Android/iOS) arasındaki köprüyü başlatır.
    //UI çizilmeden önce async işlemler yapabilmemizi sağlar.
    await WidgetsFlutterBinding.ensureInitialized();

    //Firebase servislerini başlatır.
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Firebase Authentication sağlayıcılarını ayarlar.
    //clientId → Google'ın veya facebook'un hangi uygulamadan giriş isteği geldiğini bilmesi için gerekli.
    firebaseUI.FirebaseUIAuth.configureProviders([
      firebaseUI.EmailAuthProvider(),
      GoogleProvider(
        clientId: const String.fromEnvironment(
          'GOOGLE_CLIENT_ID_ANDROID',
          defaultValue:
              '955146014965-go61a73dcd804am4tour1kv715v040r9.apps.googleusercontent.com',
        ),
      ),

      //String.fromEnvironment() → Flutter/Dart’ın compile-time environment variable okuma yöntemidir.
      //Yani uygulamayı çalıştırırken parametre olarak verdiğin değeri alır. Eğer vermediysen, defaultValue kullanılır.
      //production' ageçince mesela client id değişsin diye yeni app id oluşturulur yani yeni app.
    ]);

    //Service locator'ı başlatır
    setupLocator();

    // Timezone init (bildirim zamanlaması için)
    //Flutter’a saat dilimi bilgisi ver. Flutter sadece “UTC” saatini bilir. Yani Türkiye’de sabah 9’da planladığın bir 
    //bildirim aslında UTC’ye göre 06:00 olabilir Eğer timezone’ları yüklemezsen: Bazı cihazlarda bildirim 3 saat erken veya geç gelir.
    tz.initializeTimeZones();
    //Cihazın lokal saat dilimini Türkiye (Europe/Istanbul) olarak ayarla.
    tz_loc.setLocalLocation(tz_loc.getLocation(localLocation));
  }
}

// Environment Variables kullanımı:
//--dart-define=KEY=VALUE → Derleme sırasında KEY isminde bir environment variable oluşturur ve VALUE değerini atar.
//Kod içinde String.fromEnvironment('KEY') ile bu değeri alırsın.

//flutter run --dart-define=GOOGLE_CLIENT_ID_ANDROID=your-real-id
//flutter run --dart-define=FACEBOOK_APP_ID=your-real-id
//flutter build apk --dart-define=GOOGLE_CLIENT_ID_ANDROID=prod-id --dart-define=FACEBOOK_APP_ID=prod-id


// Default values (development için)
// android: 631494873953-k4oabd7l6a6fq5tm5h538i6j79tafm2g.apps.googleusercontent.com
// web: 631494873953-o680qu8537u4u9g8jdk2e36tjrtjibnv.apps.googleusercontent.com


//Environment Variable (Ortam değişkeni) kodun içinde sabit olarak yazılmayan, çalıştırma sırasında dışarıdan uygulamaya
      //verilen bir değerdir. Yani kodun içine gömülmez, deploy (yayınlama) veya çalıştırma anında verilir Amaç Farklı ortamlar
      //(development, staging,production) için farklı ayarlar kullanabilmek. API key gibi gizli bilgileri koda gömmemek.
      //Tek kod tabanıyla farklı platformlarda farklı değerler çalıştırabilmek. .env dosyası environment variable’ları saklamak için
      //kullanılan bir dosya formatıdır. Git projelerinde .env genelde .gitignore ile saklanır ki gizli bilgiler GitHub’a düşmesin.
      //Ama Flutter/Dart doğrudan .env dosyası okumaz; sen ek paket kullanman gerekir API key, client ID gibi bilgiler herkese
      //açık kod içinde olmamalı. Açık olursa başka kişiler bu bilgiyi çalabilir.
      //Farklı ortamlar için farklı ayarlar:
      //Development → Test Google Client ID
      //Production → Canlı Google Client ID
      //Bu sayede kodu değiştirmeden sadece parametre değiştirerek farklı ortamda çalıştırabilirsin.
