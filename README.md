## Flutter MindMate

Modern, modüler ve sürdürülebilir mimariye sahip Flutter uygulaması. Bu proje; güçlü kod üretimi, sıkı kod standartları, ölçeklenebilir modüler dosyalama ve güvenli yapılandırmalar ile geliştirilmektedir. Ayrıca bir "akıl hocası" olan MindMate; gün içinde günlük gibi kullanılabilir, kullanıcıların diledikleri sorulara yanıt bulabilecekleri, içgörü (insight) edinebilecekleri ve duygularını yansıtabilecekleri kişisel bir rehber deneyimi sunar.

> Önemli: Uygulama, yanıtları üretirken OpenAI API’sini kullanır; mobil uygulamaya yapay zeka entegrasyonu yapılmıştır.

## Özellikler
- Sesli giriş ve metne dönüştürme, metinden sese okuma
- Yapay zeka asistanı: Yanıt üretimi OpenAI API ile gerçekleştirilir (LLM tabanlı rehberlik)
- Kimlik doğrulama: E-posta/şifre ile giriş, Google ile tek tıkla giriş
- Şifre sıfırlama: E-posta ile sıfırlama bağlantısı gönderimi
- Gün içi ruh hali ile ilişkili bildirim/hatırlatma akışları
- Grafiklerle periyodik ruh hali takibi (trendler/istatistik)
- Konuşma geçmişi (history) ve geçmiş etkileşimlerden bağlamsal hatırlatma
- Yerel/uzak bildirimler, izin yönetimi ve tıklama davranışları
- Modüler feature mimarisi, Provider tabanlı state yönetimi
- Genişletilebilir servis katmanı ve `get_it` ile bağımlılık enjeksiyonu
- Responsive UI (`responsive_framework`) ve özelleştirilebilir AppBar bileşenleri

## Screens

<table style="width:100%; border-collapse: collapse;">
  <tr>
    <td><img src="https://github.com/user-attachments/assets/ca111334-3e68-453f-b49c-bf0ce34f98b6" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/5f1bf555-d344-4405-932c-13496e266710" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/86052c67-6390-467b-9e84-617d2bbbff2a" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/101c5092-2ae4-4804-b840-ef52f062b60b" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0605b15b-cd82-46e8-9887-8a73df785d31" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/4f80f6ef-5f8c-4350-ab6d-e4d1d114cb11" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/e1e2ce55-e3f4-4a0e-8f2c-7fac592c35d4" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/6df9c97e-95f4-4916-817a-697276c2fad6" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/ce6614b7-03d0-404a-9244-b4b3833adb10" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/021cc449-d8c2-49e9-9960-3f7c3bdbac40" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/3ae22b53-2aac-489e-b372-9eaca8528a8a" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/174bfa5a-897a-40ad-b9b4-c58efd4dbd50" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/3d878bdb-3864-4e8c-8293-299d737ad14a" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/31330b16-3385-403c-ad33-2ec8bbb75288" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/339056fa-7d26-4512-97f8-d29a16cfa0fa" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/facdd231-b3cd-4a3c-8f2b-fde796702255" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/2b616f5b-b68c-4bf2-ae88-46a62542405f" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/8fbdc782-d254-47d9-afa4-b2bf2662fb19" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/e4640f64-22ae-42cb-8ffd-eb865b2757d4" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/c92515bc-982c-4f7c-b48e-474a275ea08f" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/beda2568-1962-4f9f-a83c-aa5be303c8ef" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/6d804306-f2cd-4011-bfc7-1660fdb55f1c" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/c5cca22b-beae-42d3-a580-53ab0b1a563d" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/6c6d2ebc-47de-420e-96af-46e55f59a2ea" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/3e722f05-2423-443b-9ee8-1fd54ec30400" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/11b1ffae-c889-466c-9af0-4def6b297a30" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/4dd70507-d60e-49ba-acef-22daef039b0b" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/542ae7ad-a3d3-4aef-8f63-bb2e2731f07c" width="100%" /></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/53895618-8e36-42cf-b6cb-d7f5cb8e750d" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/d13fface-55f8-4f85-949d-1f3ffc83db08" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/6b644f0c-25d1-4d76-9504-1525fb94b631" width="100%" /></td>
    <td><img src="https://github.com/user-attachments/assets/58653246-6458-4021-8950-387445d5c7a8" width="100%" /></td>
  </tr>
</table>


### İçindekiler
- Proje Özeti
- Mimarî ve Dosya Yapısı
- Komutlar ve Otomasyon (rps)
- Kod Üretimi ve Kaynak Yönetimi
- Ortam Değişkenleri (Env) ve Güvenlik
- Durum Yönetimi ve Katmanlar
- UI ve Tasarım Kuralları
- Loglama ve Hata Yönetimi
- Lint Kuralları ve Kod Standartları
- Kullanılan Teknolojiler ve Paketler
- Yapay Zeka Entegrasyonu (OpenAI API)
- Bildirim Servisi (NotificationService)
- Flutter Sürüm Yönetimi (Sidekick)
- build.yaml Yapılandırması
- Test (UI: Maestro)
---

## Proje Özeti
MindMate, özelliklerin `features/` altında modülerleştiği, servislerin `products/` altında toplandığı, bağımlılıkların `get_it` ile yönetildiği, kaynakların `flutter_gen_runner` ile otomatik üretildiği bir Flutter uygulamasıdır. Kodda sabit (hardcoded) string ve sayısal değerler kullanılmaz; metinler `enums/strings_enum.dart`, boyutlar `products/enums/sizes_enum.dart` altında enhanced enum yapılarıyla yönetilir. Ayrıca uygulama yanıtlarını üretmek için OpenAI API’si kullanılır; böylece mobil uygulamaya yapay zeka entegrasyonu sağlanmıştır.

---

## Mimarî ve Dosya Yapısı
Örnek dizin yapısı:

```
lib/
  features/
    <feature_name>/
      view/
        <feature_name>_view.dart         // Sadece UI ağaçları
      sub_view/
        <parçalı_widgetlar>.dart        // UI parçaları (widget extraction)
      view_model/
        <feature_name>_view_model.dart   // İş mantığı, state, servis çağrıları
      provider/
        <feature_name>_provider.dart     // Provider tanımları (ref erişimi sadece VM'de)

  products/
    appbars/
      <custom_appbarlar>.dart
    enums/
      sizes_enum.dart                    // ImageSizesEnum, TextSizesEnum, IconSizesEnum, WidgetSizesEnum, AppbarSizesEnum (enhanced enum)
      strings_enum.dart                  // Tüm sabit metinler
    services/
      notification_service.dart          // Bildirim ve izin akışları

  service_locator/
    service_locator.dart                 // get_it bağımlılık kayıtları

gen/                                      // flutter_gen çıktı dizini

assets/
  images/ ...
  colors/colors.xml                       // Renkler (istenirse)
```

Temel prensipler:
- `view.dart` dosyalarında sadece Widget ağaçları bulunur. İş mantığı, doğrulamalar, servis çağrıları ve state, `view_model/` veya `provider/` katmanındadır.
- Erişim modeli: Provider’lar yalnızca `ref` ile ve sadece ViewModel katmanından erişilmelidir. UI katmanı sadece gösterim yapar.
- AppBar bileşenleri `products/appbars/` altına extract edilerek taşınır.

---

## Komutlar ve Otomasyon (rps)
Sürekli kullanılan komutlar `rps.yaml` üzerinden kısaltılır. Önerilen script’ler:

```yaml
scripts:
  gen_flutter: flutter pub run build_runner build --delete-conflicting-outputs
  gen_watch: flutter pub run build_runner watch --delete-conflicting-outputs
  pub_get: flutter pub get
  analyze: flutter analyze
  format: dart format lib test
```

Kullanım:
```
rps run gen_flutter
rps run gen_watch
rps run analyze
```

Zorunlu kurallar:
- `flutter_gen_runner` ile kod üretimi esnasında her değişiklikte: `rps run gen_flutter` çalıştırılmalı.
- `assets/` altında değişiklik yapıldığında: `rps run gen_flutter` çalıştırılmalı.

---

## Kod Üretimi ve Kaynak Yönetimi
- Kaynaklar (assets, renkler, fontlar, görseller) `flutter_gen_runner` ile yönetilir ve `gen/` altında kod üretimi sağlanır.
- JSON Serializable üretimi sadece `lib/models/` altında `*_model.dart` dosyaları için yapılır.
- `pubspec.yaml` dosyasına eklenen her paket için başında 1-2 kelimelik yorum satırı bulunmalıdır (dokümantasyon için zorunlu kural).

---

## Ortam Değişkenleri (Env) ve Güvenlik
- API anahtarları ve gizli bilgiler `.env` içinde tutulur, koda gömülmez.
- Env değerleri `envied` paketiyle yönetilir. Üretim sırasında Envied, tip güvenli erişim sağlar.
- `.env` dosyası VCS’e (git) dahil edilmemelidir.

Kullanım notu:
- Nasıl kullanılacağına dair örnek anahtarlar ve açıklamalar `.env.example` dosyasında gösterilmiştir. Bu dosyayı kopyalayıp yeniden adlandırarak `.env` oluşturun ve değerleri doldurun; ardından kod üretimi için `rps run gen_flutter` çalıştırın.

Örnek `.env` (örnek anahtarlar):
```
API_BASE_URL=https://api.example.com
SENTRY_DSN=...
FIREBASE_KEY=...
```

---

## Durum Yönetimi ve Katmanlar
- State yönetimi `provider` ile yapılır.
- Provider’lara sadece ViewModel katmanında `ref` ile erişilir; UI katmanı sadece veriyi gösterir ve kullanıcı etkileşimini iletir.
- Servis katmanında hata fırlatma (throw) yapılabilir; üst katman handle edecektir. UI katmanında kesinlikle `throw` kullanılmaz.

---

## UI ve Tasarım Kuralları
- Responsive tasarım `responsive_framework` ile ve `main.dart` içinde breakpoints tanımlanarak sağlanmalıdır.
- Kodda sabit (hardcoded) string yasaktır. Tüm metinler `products/enums/strings_enum.dart` içinde merkezi yönetilir.
- Sabit sayısal değerler yasaktır. Tüm boyutsal değerler `products/enums/sizes_enum.dart` içinde enhanced enum olarak tanımlıdır:
  - `ImageSizesEnum`
  - `TextSizesEnum`
  - `IconSizesEnum`
  - `WidgetSizesEnum`
  - `AppbarSizesEnum`
- Hangi tür istendiyse sadece o türe ait enum oluşturulmalıdır.

Renkler:
- Renk tanımları istenirse `assets/colors/colors.xml` içinde tutulur ve `flutter_gen` ile yönetilir.

AppBar’lar:
- Ekranlardaki tüm appbar’lar extract edilerek `products/appbars/` altına taşınmalıdır.

---

## Loglama ve Hata Yönetimi
- Debug amaçlı `print` yerine mutlaka `Logger` paketi kullanılmalıdır.
- Kritik ve çökme ihtimali olan tüm kodlar `try-catch` içinde yazılmalıdır.
- `catch` bloklarında hatalar `Logger` ile kaydedilmelidir.
- `throw` sadece ViewModel veya Service katmanında (üst katman handle edecekse) kullanılabilir; UI katmanında yasaktır.

---

## Lint Kuralları ve Kod Standartları
`analysis_options.yaml` içinde aşağıdaki kurallar tanımlanmalıdır (özet):
- `flutter_lints`
- `always_declare_return_types: true`
- `always_put_required_named_parameters_first: true`
- `always_require_non_null_named_parameters: true`
- `always_use_package_imports: true`
- `avoid_print: true`
- `prefer_final_locals: true`
- `avoid_empty_else: true`
- `sort_constructors_first: true`
- `use_super_parameters: true`

Kod yazım rehberi:
- Kısa ve anlamsız değişken isimlerinden kaçının; açık ve anlamlı isimler kullanın.
- İş mantığı ViewModel/Service katmanında, UI sadece görselleştirme katmanında kalmalıdır.
- Bağımlılıklar `get_it` ile `service_locator/service_locator.dart` dosyasında yönetilmelidir.

Not: Ekip içi geliştirme süreçlerini standartlaştırmak amacıyla “Cursor rules” ayrı bir belge/depo yönergesi olarak tanımlanmıştır. Bu README’de tekrara düşmemek için ayrıntıları listelenmemiştir; projede uygulanması beklenir.

---

## Kullanılan Teknolojiler ve Paketler
- dart_openai: OpenAI API istemcisi (LLM tabanlı yanıt üretimi).
- Flutter & Dart: Çapraz platform UI geliştirme.
- Riverpod 3 (`riverpod`, `flutter_riverpod`): State yönetimi; `ref` erişimi sadece ViewModel katmanında.
- get_it: Servis ve bağımlılık enjeksiyonu (`service_locator/service_locator.dart`).
- responsive_framework: Mobil/tablet/web/masaüstü için uyarlanabilir UI.
- flutter_gen_runner + build_runner: Asset, renk, font gibi kaynakların otomatik kod üretimi (`gen/`).
- json_serializable + json_annotation: Modeller için `g.dart` üretimi (yalnızca `lib/models/**_model.dart`).
- envied: Ortam değişkenlerinin tip güvenli yönetimi (API anahtarları, token vb.).
- flutter_dotenv: .env dosyalarını yüklemek için (gerekli durumlarda).
- logger: Loglama; `print` yerine zorunlu kullanım.
- dio: HTTP istemcisi.
- connectivity_plus: Ağ durumu kontrolü.
- permission_handler: İzin yönetimi.
- image_picker: Görsel seçimi.
- url_launcher: Harici bağlantı/uygulama açma.
- flutter_local_notifications + timezone: Yerel bildirimler ve zamanlama.
- fl_chart: Grafikler ve ruh hali trendleri.
- equatable: Değer eşitliği için yardımcılar.
- kartal: Yardımcı uzantılar.
- Firebase: `firebase_core`, `cloud_firestore`, `firebase_auth`, `firebase_storage`, `firebase_ui_auth`, `firebase_ui_oauth_google`, `firebase_ui_localizations`, `google_sign_in`.
- Flutter Sidekick: Flutter sürüm pinleme ve kanal yönetimi (önerilir).
- Maestro: UI test otomasyonu.

Not: Paket sürümleri ve ek açıklamalar için `pubspec.yaml` dosyasındaki yorumlara bakınız.

---

## Yapay Zeka Entegrasyonu (OpenAI API)
- Amaç: Kullanıcı sorularına akıllı, bağlamsal ve empatik yanıtlar üretmek.
- Altyapı: OpenAI API (LLM) kullanılarak yanıt oluşturma.
- Güvenlik: API anahtarları `.env` içinde saklanır ve `envied` ile tip güvenli erişilir; kaynağa gömülmez.
- Veri: Mümkün olduğunca minimal veri iletilir; konuşma geçmişi bağlamı, açık rıza ve gizlilik göz önünde bulundurularak kullanılır.
- Hata Dayanıklılığı: Ağ hatalarında kullanıcıya uygun geri bildirim verilir; kritik kodlar `try-catch` ile sarılır ve `Logger` ile loglanır.

Not: Üretim anahtarlarını paylaşmayın; oran/limitler için OpenAI panelinizi izleyin.

---

## Flutter Sürüm Yönetimi (Sidekick)
- Proje başlamadan önce Sidekick ile Flutter sürümünü sabitleyin (pin). Böylece ekip içinde aynı SDK kullanılır ve inşa farkları azalır.
- Gerekirse Sidekick içinden kanal (stable/beta) ve spesifik sürüm seçilebilir.

Kurulum için: Sidekick uygulamasını indirip kurun, projeyi tanıtın ve sürümü pinleyin. Ardından terminalde `flutter --version` ile doğrulayın.

---

## build.yaml Yapılandırması
`json_serializable` üretiminin yalnızca `lib/models/*_model.dart` dosyaları için yapılması hedeflenir. Örnek `build.yaml` yapılandırması aşağıdaki gibi olabilir:

```yaml
targets:
  $default:
    sources:
      include:
        - lib/**
    builders:
      json_serializable:
        generate_for:
          include:
            - lib/models/**_model.dart
```

Bu yaklaşım derleme süresini optimize eder ve istenmeyen dosyalar için `g.dart` üretimini engeller.

---

## Bildirim Servisi (NotificationService)
Dosya: `lib/products/services/notification_service.dart`

Yetenekler (genel):
- Bildirim izin akışı ve durum kontrolü
- Yerel ve/veya push bildirim planlama/gösterimi
- Uygulama ön/arka planda iken davranışlar

---

## Test (UI: Maestro)
- UI testleri Maestro ile gerçekleştirilmelidir.
- Senaryolar `maestro/` dizininde tutulabilir.
- Kurulum ve komutlar için Maestro dokümantasyonuna bakınız.

---



