import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Navigation extension for BuildContext
/// Tüm widget türlerinde (StatelessWidget, StatefulWidget, ConsumerWidget, vb.) kullanılabilir
extension NavigationMixin on BuildContext {
  /// Yeni sayfaya yönlendirir (animasyonsuz geçiş)
  void navigateTo(Widget widget) {
    route.navigation.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        opaque: true,
      ),
    );
  }

  /// Mevcut sayfayı kapatır ve geri döner
  void popPage() {
    route.navigation.pop();
  }
}
