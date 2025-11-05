// Uygulama genelinde kullanılan süreler (Duration) için enhanced enum

enum DurationsEnum {
  speechListenMax(Duration(minutes: 5)),
  speechPause(Duration(seconds: 15)),
  motivationDelay(Duration(hours: 2));

  const DurationsEnum(this.value);
  final Duration value;
}
