import 'package:flutter/material.dart';

import 'colors.dart';

class StyleManager {
  static Theme selectTime(context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: ColorManager.primaryColor, //
            // onPrimary: ColorManager.yellowLiner, //selected text color
            // onSurface: ColorManager.yellowLiner, //color header and day text
            // background: ColorManager.yellowLiner,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white, textStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ), // color of button's letters
              backgroundColor: ColorManager.primaryColor,
              // Background color
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
        child: child!,
      );
}
