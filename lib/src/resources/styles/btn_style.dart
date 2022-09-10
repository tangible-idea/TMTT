import 'package:flutter/material.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';


class BtnStyle {
  static ButtonStyle plain = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.primary_04; // if (states.contains(MaterialState.pressed)) {}
    }),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(14)
    ),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
      );
    }),
  );

  static ButtonStyle disabledPlain = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.primary_01; // if (states.contains(MaterialState.pressed)) {}
    }),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(14)
    ),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
      );
    }),
  );

  static ButtonStyle gray = ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return MyColor.gray_02;
      }
      return null;
    }),
    elevation: MaterialStateProperty.resolveWith((states) {
      return 0;
    }),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.bg04; // if (states.contains(MaterialState.pressed)) {}
    }),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(14)
    ),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      );
    }),
  );

  static ButtonStyle grayRadius = ButtonStyle(
    overlayColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return MyColor.gray_02;
      }
      return null;
    }),
    elevation: MaterialStateProperty.resolveWith((states) {
      return 0;
    }),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.bg04; // if (states.contains(MaterialState.pressed)) {}
    }),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(14)
    ),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      );
    }),
  );
}