// Uygulama genelinde kullanılan süreler (Duration) için enhanced enum

enum DurationsEnum {
  speechListenMax(Duration(minutes: 5)),
  speechPause(Duration(seconds: 15));

  const DurationsEnum(this.value);
  final Duration value;
}
