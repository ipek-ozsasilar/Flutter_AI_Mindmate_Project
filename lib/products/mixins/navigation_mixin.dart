import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

mixin NavigationMixin<T extends StatefulWidget>  on State<T> {
  void navigateTo( Widget widget) {
    context.route.navigation.push(MaterialPageRoute(builder: (context) => widget),);
  }

  void popPage() {
    context.route.navigation.pop();
  }

}