import 'package:flutter/material.dart';

class AppBoxShadow {
  static List<BoxShadow> containerBoxShadow() => [
        boxShadow03(),
        boxShadow3(),
      ];

  static List<BoxShadow> selectedBoxShadow() => [
        boxShadow01(),
        boxShadow1(),
      ];

  static boxShadow01() => BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        spreadRadius: .5,
        blurRadius: 1,
        offset: const Offset(0, 1), //
      );

  static boxShadow1() => BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        spreadRadius: .5,
        blurRadius: 1,
        offset: const Offset(1, 0),
      );

  static boxShadow3() => BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        spreadRadius: 2,
        blurRadius: 4,
        offset: const Offset(3, 0), //
      );

  static boxShadow03() => BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        spreadRadius: 2,
        blurRadius: 4,
        offset: const Offset(0, 3), //
      );
}
