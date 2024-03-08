import 'package:flutter/material.dart';

navigateTo(BuildContext context, Widget screen, {bool replace = false}) {
  replace
      ? Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return screen;
          },
        ))
      : Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return screen;
          },
        ));
}

pop(BuildContext context) {
  Navigator.of(context).pop();
}

maybePop(BuildContext context) {
  Navigator.maybeOf(context)?.pop();
}
