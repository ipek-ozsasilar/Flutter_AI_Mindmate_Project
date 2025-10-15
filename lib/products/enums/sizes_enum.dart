enum SizesEnum {
  iconSize(24);

  final double value;
  const SizesEnum(this.value);
}

enum ScreenSizesEnum {
  mobileSmall(0),
  mobileLarge(480),
  tabletSmall(481),
  tabletLarge(800),
  desktopSmall(801),
  desktopLarge(1200),
  xlLarge(1201);

  final double value;
  const ScreenSizesEnum(this.value);
}



/**
 * Mesela rps script ile:

rps new_project my_app


rps.yaml içeriği:

scripts:
  new_project:
    - flutter create {{ args[0] }}
    - cd {{ args[0] }}
    - dart pub add get_it envied responsive_framework flutter_gen
    - dart pub add --dev very_good_analysis build_runner json_serializable
    - echo "include: package:very_good_analysis/analysis_options.yaml" > analysis_options.yaml
    - echo "API_KEY=123456" > .env
    - dart run envied build
    - mkdir lib/core && touch lib/core/service_locator.dart
    - echo "rules:\n  - 'Use get_it for dependency management'" > .cursor/rules.yaml


Böylece bir komutla:
✅ Proje oluşturulur
✅ Paketler eklenir
✅ Linter, env, service locator, cursor rules vs. hepsi ayarlanır

Script (RPS / Mason / Bash) = Gerçek otomasyon aracı


 */