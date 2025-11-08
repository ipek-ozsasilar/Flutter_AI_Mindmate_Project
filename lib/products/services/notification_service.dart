import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_mindmate_project/models/notification_model.dart';
import 'package:flutter_mindmate_project/products/enums/strings_enum.dart';
import 'package:flutter_mindmate_project/products/services/firestore_service.dart';
import 'package:flutter_mindmate_project/products/navigation/app_navigator.dart';
import 'package:flutter_mindmate_project/features/notifications/notifications_view.dart';
import 'package:flutter_mindmate_project/service_locator/service_locator.dart';

/// Yerel bildirimlerin (flutter_local_notifications) tamamını yöneten servis.
/// - İzinler, kanal oluşturma, zamanlama, tıklama ile navigasyon
class NotificationService {
  NotificationService();
  final String icon = '@drawable/ic_notification';
  //Flutter kodun ile Android/iOS işletim sisteminin bildirim servisleri (NotificationManager, UNNotificationCenter)
  //arasında köprü kurar. Yani sen “bildirim göster” diyorsun o da gidip Android’e AlarmManager üzerinden şu bildirimi planla” diyor
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  bool _initialized = false;

  /// Bildirim altyapısını hazırlar ve tıklama callback'ini bağlar.
  /// Uygulama boyunca 1 kez çağrılması yeterlidir.
  Future<void> init() async {
    if (_initialized) return;
    try {
      //FlutterLocalNotificationsPlugin'in Android tarafındaki bildirim başlangıç ayarlarını tanımlıyor.
      //Android tarafında bildirim gösterirken kullanılacak varsayılan simgeyi @drawable/ic_notification olarak ayarla.
      AndroidInitializationSettings androidInit = AndroidInitializationSettings(
        icon,
      );

      //AndroidInitializationSettings nesnesini FlutterLocalNotificationsPlugin’e geçmeden önce bir “ortak yapı” haline getiriyor
      //Yani senin bildirim sisteminin hem Android, hem iOS tarafındaki ayarlarını tek bir yapı içinde topluyor
      //Flutter bir “cross-platform” framework olduğu için, bildirim sisteminin hem Android, hem iOS versiyonu vardır:
      //İşte InitializationSettings bu ikisini tek bir çatı altında toplar. Bu sayede uygulama hangi
      //platformda çalışıyorsa, FlutterLocalNotificationsPlugin o platformun ayarını otomatik alır.
      InitializationSettings initSettings = InitializationSettings(
        android: androidInit,
      );

      // Bildirim tıklandığında notifications ekranına yönlendir
      // (Global navigatorKey ile context'siz navigation sağlanır)
      //Bildirim sistemini başlatır
      await _plugin.initialize(
        //burada Android (ve varsa iOS) için gereken başlangıç ayarlarını plugin’e iletiyorsun
        initSettings,
        //Bu parametre, kullanıcı bildirime tıkladığında ne yapılacağını belirler.
        onDidReceiveNotificationResponse: _onNotificationTap,
      );

      // Android kanal oluşturma (yüksek öncelik) Flutter Local Notifications sisteminin Android tarafındaki “bildirim
      //kanalı” (notification channel) oluşturma işlemini yapıyor. Android’in bildirim sistemi iOS’tan farklı olarak
      //“kanal (channel)” mantığıyla çalışır, ve bu kod tam olarak onu kuruyor. Uygulamanın göndereceği bildirimlerin
      //hangi “kanal” üzerinden gideceğini Android’e bildirmek. Yani bildirimlerin sesi, titreşimi, önceliği
      //(importance), kategorisi gibi ayarları bu kanaldan yönetirsin
      final AndroidNotificationChannel channel = AndroidNotificationChannel(
        //Kanalın benzersiz ID’si. Her bildirim kanalı için benzersiz bir ID olmalı.
        StringsEnum.notificationChannelId.value,
        //Kanalın ismi. Bu isim kullanıcıya gösterilir.
        StringsEnum.notificationChannelName.value,
        //Kanalın açıklaması. Bu açıklama kullanıcıya gösterilir.
        description: StringsEnum.notificationChannelDesc.value,
        //Kanalın önceliği. Bu öncelik bildirimlerin gösterilme sırasını belirler.
        importance: Importance.high,
      );

      //FlutterLocalNotificationsPlugin içinden sadece Android’e özel API’yi al.
      //Burada biz sadece Android’in kanal sistemine erişmek istiyoruz
      final AndroidFlutterLocalNotificationsPlugin? androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      //Android sistemine “şu kanalı oluştur” der. Bir defa oluşturuldu mu, cihaz onu saklar (kullanıcı silebilir ama
      //sen yeniden tanımlamazsın). yüksek öncelikli bildirimler bu kanal üzerinden gidiyor.
      //Kullanıcı isterse kendi telefon ayarlarından bu kanalın sesini, titreşimini, önceliğini değiştirebilir.
      await androidPlugin?.createNotificationChannel(channel);

      _initialized = true;
    } catch (e) {
      // silently handle
    }
  }

  /// Bildirim tıklandığında çağrılır - NotificationsView'a yönlendirir.
  /// navigatorKey.currentContext ile BuildContext olmadan push yapılır.
  // Response: Bildirim tıklandığında gelen veri Yani sistem sana “hangi bildirime, nasıl tıklanıldı” gibi verileri
  //bu nesneyle yollar.
  void _onNotificationTap(NotificationResponse response) {
    // main.dart'tan import edilen navigatorKey kullanarak yönlendirme yap
    // Navigate to notifications screen
    //Eğer sen o an widget context’inde değilsen (örneğin bir servis sınıfındaysan, ya da uygulama kapalıyken bildirime
    //tıklanmışsa), context’e erişimin yoktur İşte burada navigatorKey devreye girer
    final BuildContext? context = navigatorKey.currentContext;
    if (context != null) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NotificationsView(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          opaque: true,
        ),
      );
    } else {}
  }

  //Cihazda uygulamanın bildirim göndermesine izin var mı? kontrol eder ve yoksa kullanıcıdan ister
  //Bildirim izni(POST_NOTIFICATIONS) verilirse true, verilmezse false döner.
  //Bu izin android 13+ için gereklidir. Eğer cihaz Android 12 veya daha düşükse hiçbir şey döndürmez (null gelir)
  Future<bool> requestPermissionIfNeeded() async {
    try {
      //FlutterLocalNotificationsPlugin içinden sadece Android’e özel API’yi al.Yani Bu işlemi sadece Android sisteminde yap.
      final bool? granted = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      final bool allowed = granted ?? true; // Android 12- için her zaman true

      return allowed;
    } catch (e) {
      return false;
    }
  }

  //Uygulamanın “exact alarm” (tam zamanlı alarm) iznine sahip olup olmadığını kontrol etmektir.
  //Uygulamanın exact alarm planlama yetkisi var mı? Eğer var ise true, yoksa false döner.
  Future<bool> canScheduleExactAlarms() async {
    try {
      final bool? exactAlarms = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.canScheduleExactNotifications();

      return exactAlarms ?? false;
    } catch (e) {
      return false;
    }
  }

  //“exact alarm” (tam zamanlı bildirim veya zamanlama) yapmak özel bir izin yoksa izin ister.
  Future<void> requestExactAlarmsPermissionIfNeeded() async {
    try {
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestExactAlarmsPermission();
    } catch (e) {}
  }

  //Uygulama içinde belirli bir süre sonra otomatik bildirim planla, ve tüm Android izinlerini, zaman dilimini ve hataları yönet
  Future<void> scheduleMotivation({
    //Bildirimin kaç saniye/dakika/ saat sonra gösterileceğini belirler
    required Duration delay,
    //Bildirimin içeriğini belirler. Bu genellikle motivasyon metni olur.
    required String body,
    //Eğer true ise, bildirim hemen gösterilir. Eğer false ise, bildirim planlanır ve zamanı geldiğinde gösterilir.
    bool alsoShowNow = false,
  }) async {
    try {
      //Bildirim servisini başlatır
      await init();
      //Cihazda uygulamanın bildirim göndermesine izin var mı? kontrol eder ve yoksa kullanıcıdan ister
      await requestPermissionIfNeeded();
      //Uygulamanın “exact alarm” (tam zamanlı alarm) izni ister
      await requestExactAlarmsPermissionIfNeeded();

      // Exact alarm izni kontrolü
      final bool canExact = await canScheduleExactAlarms();
      final AndroidScheduleMode scheduleMode = canExact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle;

      //Bu, bildirim nasıl görünecek ve nasıl davranacak kısmıdır
      final AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            StringsEnum.notificationChannelId.value,
            StringsEnum.notificationChannelName.value,
            channelDescription: StringsEnum.notificationChannelDesc.value,
            importance: Importance.high,
            priority: Priority.high,
            icon: icon,
          );
      //NotificationDetails, bildirim için genel bir yapıdır. Android ve iOS için ayrı ayrı ayarlar yapılabilir.
      final NotificationDetails details = NotificationDetails(
        android: androidDetails,
      );

      // Burada saat farkı sorunlarını önlemek için timezone (zaman dilimi) kullanılıyor
      // final DateTime nowLocal = DateTime.now();
      final tz.TZDateTime nowIstanbul = tz.TZDateTime.now(
        tz.getLocation('Europe/Istanbul'),
      );

      // İstanbul timezone'unda şu anki zaman + delay = scheduled time
      //bildirimin planlanacağı zaman.
      final tz.TZDateTime scheduled = nowIstanbul.add(delay);

      //Bildirime benzersiz ID ver
      final int notificationId = scheduled.millisecondsSinceEpoch ~/ 1000;

      // Scheduled time kontrolü
      //fonksiyonun bildirimi yanlış zamanda planlama riskini kontrol ettiği kısım
      final tz.TZDateTime nowCheck = tz.TZDateTime.now(
        tz.getLocation('Europe/Istanbul'),
      );
      //Bildirimin planlanacağı zaman ile şu anki zamanın farkını hesapla
      final Duration timeUntilNotification = scheduled.difference(nowCheck);

      //Eğer bildirimin planlanacağı zaman şu anki zamanından önceyse, hata logla
      if (timeUntilNotification.isNegative) {
        //Eğer bildirimin planlanacağı zaman şu anki zamanından önceyse, hata logla
      } else {}

      //Timezone destekli planlama bildirim planlanır
      await _plugin.zonedSchedule(
        //Bildirimin benzersiz ID’si. Her bildirim için benzersiz bir ID olmalı.
        notificationId, // unique id yaklaşımı
        //Bildirimin başlığı.
        StringsEnum.motivationTitle.value,
        //Bildirimin içeriği. Bu genellikle motivasyon metni olur.
        body,
        //Bildirimin planlanacağı zaman.
        scheduled,
        //Bildirim için genel bir yapıdır. Android ve iOS için ayrı ayrı ayarlar yapılabilir.
        details,
        //Bildirim nasıl görünecek ve nasıl davranacak kısmıdır
        androidScheduleMode: scheduleMode,
      );

      // Bildirimi Firestore'a kaydet
      try {
        final DateTime now = DateTime.now();
        final String date = now.toString().split(' ')[0];
        final String time =
            '${scheduled.hour.toString().padLeft(2, '0')}:${scheduled.minute.toString().padLeft(2, '0')}';

        //Bildirimi Firestore'a kaydet
        final NotificationModel notificationModel = NotificationModel(
          notificationId: notificationId,
          date: date,
          time: time,
          title: StringsEnum.motivationTitle.value,
          body: body,
          isRead: false,
        );

        await _firestoreService.addNotificationToFirestore(notificationModel);
      } catch (e) {}

      // Pending notification'ları kontrol et (debug için)
      //Pending (bekleyen) bildirimleri logla
      //Pending Notification, henüz zamanı gelmemiş, ama sistem tarafından gelecekte gösterilmek üzere planlanmış bildirimi ifade ede
      // ignore: unused_local_variable
      final List<PendingNotificationRequest> pendingNotifications =
          await _plugin.pendingNotificationRequests();

      //Eğer alsoShowNow true ise, hemen bildirim göster
      if (alsoShowNow) {
        //Bildirim göster
        await _plugin.show(
          notificationId + 1,
          StringsEnum.motivationTitle.value,
          '[TEST] Planlandı: ${scheduled.toString()}',
          details,
        );
      }
    } catch (e) {}
  }
}
