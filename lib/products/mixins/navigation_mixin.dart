import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

mixin NavigationMixin<T extends ConsumerStatefulWidget>  on ConsumerState<T> {
  void navigateTo( Widget widget) {
    context.route.navigation.push(MaterialPageRoute(builder: (context) => widget),);
  }

  void popPage() {
    context.route.navigation.pop();
  }

}