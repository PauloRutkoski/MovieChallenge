import 'package:flutter/material.dart';

class Nav {
  static to(BuildContext context, Object screen) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen as Widget,
        ));
  }

  static back(BuildContext context) {
    Navigator.pop(context);
  }
}
