enum IconSizesEnum {
  iconSize(24),
  moodIconSize(48);

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
  splashTitleSize(60),
  messageBottomAppbarTextSize(12),
  todayCardTitleSize(22),
  subtitleSize(14),
  chatTimeSize(12);

  final double value;
  const TextSizesEnum(this.value);
}

enum WidgetSizesEnum {
  elevatedButtonHeight(60),
  splashImageContainerHeight(350),
  startChatContainerHeight(150),
  startChatContainerWidth(200),
  todayCardHeight(200),
  chatCardHeight(120),
  borderRadius(16),
  moodIconContainerSize(60),
  limitIndicatorSize(50),
  historyCardMinHeight(150),
  historyChatItemHeight(80);

  final double value;
  const WidgetSizesEnum(this.value);
}

enum AppbarSizesEnum {
  messageToolbarHeight(100),
  splashToolbarHeight(100),
  logInToolbarHeight(150),
  leadingWidth(135);

  final double value;
  const AppbarSizesEnum(this.value);
}
