import 'package:flutter/material.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';


class BtnStyle {

  static ButtonStyle plain = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.kPrimary; // if (states.contains(MaterialState.pressed)) {}
    }),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(14)
    ),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      );
    }),
  );

  static ButtonStyle disabledPlain = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.kGrey2; // if (states.contains(MaterialState.pressed)) {}
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

  static ButtonStyle whiteOutlineRadius = OutlinedButton.styleFrom(
    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // <-- Radius
    ),
    side: const BorderSide(
        width: 2.0,
        color: MyColor.kGrey5),
  );

  static ButtonStyle whiteOutlineRadius2 = OutlinedButton.styleFrom(
      backgroundColor: MyColor.white,
      side: const BorderSide(color: MyColor.kPrimary, width: 0.8),
      padding: const EdgeInsets.all(24),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18))
      )
  );

  static ButtonStyle valentineButton = OutlinedButton.styleFrom(
      backgroundColor: MyColor.kValenRed,
      side: const BorderSide(color: MyColor.kValenRed, width: 0.8),
      padding: const EdgeInsets.all(24),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      )
  );

  static ButtonStyle valentineDisableButton = OutlinedButton.styleFrom(
      backgroundColor: MyColor.kGrey2,
      side: const BorderSide(color: MyColor.kGrey2, width: 0.8),
      padding: const EdgeInsets.all(24),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))
      )
  );

  static ButtonStyle negative = ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      return MyColor.point02;
    }),
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.all(14)
    ),
    shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      );
    }),
  );

}