enum IconSizesEnum {
  iconSize(24);

  final double value;
  const IconSizesEnum(this.value);
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

enum TextSizesEnum {
  appTitleSize(20),
  generalSize(16),
  googleSize(24),
  splashTitleSize(60);

  final double value;
  const TextSizesEnum(this.value);
}

enum WidgetSizesEnum {
  splashImageContainerHeight(350);

  final double value;
  const WidgetSizesEnum(this.value);
}

enum AppbarSizesEnum {
  toolbarHeight(100),
  leadingWidth(135);

  final double value;
  const AppbarSizesEnum(this.value);
}