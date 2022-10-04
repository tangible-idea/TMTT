
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmtt/generated/assets.dart';


class FragmentHeader extends StatelessWidget {

  Function()? onCancelPressed;

  FragmentHeader({
    this.onCancelPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: Row(
        children: [
          Spacer(),
          IconButton(
            onPressed: () {
              onCancelPressed?.call();
            },
            icon: SvgPicture.asset(Assets.imagesIcCancel),
          ),
        ],
      ),
    );
  }

}