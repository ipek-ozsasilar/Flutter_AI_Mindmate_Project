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
