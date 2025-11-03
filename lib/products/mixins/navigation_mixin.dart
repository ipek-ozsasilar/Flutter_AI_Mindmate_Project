import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

/// Navigation extension for BuildContext
/// Tüm widget türlerinde (StatelessWidget, StatefulWidget, ConsumerWidget, vb.) kullanılabilir
extension NavigationMixin on BuildContext {
  /// Yeni sayfaya yönlendirir
  void navigateTo(Widget widget) {
    route.navigation.push(MaterialPageRoute(builder: (context) => widget));
  }

  /// Mevcut sayfayı kapatır ve geri döner
  void popPage() {
    route.navigation.pop();
  }
}
