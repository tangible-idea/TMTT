
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/screens/base/base_widget.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class InboxItem extends StatelessWidget {

  String tag = '';
  bool isRead = false;
  bool useMargin = false;
  bool isPlay = false;

  InboxItem({
    super.key,
    this.tag = '',
    this.isRead = false,
    this.useMargin = true,
    this.isPlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 30, bottom: 30),
          margin: useMargin ? const EdgeInsets.only(left: 24, right: 24, top: 6, bottom: 6) : null,
          decoration: BoxDecoration(
            color: isRead ? MyColor.kGrey2 : MyColor.kPrimary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: MyColor.white,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipOval(
                        child: Image.asset(Assets.imagesHandHold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(Assets.imagesAirplaneLine, fit: BoxFit.cover),
                        Positioned(
                          top: 32,
                          child: PlainText(
                            text: tag,
                            style: MyTextStyle.body1Bold.copyWith(
                              fontSize: 14,
                              color: MyColor.white,
                            ),
                          ),
                        ),
                        isPlay ? _AnimatedSlideToRight(
                          isPlay: isPlay,
                          child: SvgPicture.asset(Assets.imagesAirplane, fit: BoxFit.cover),
                        ) :
                        SvgPicture.asset(Assets.imagesAirplane, fit: BoxFit.cover),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 57,
                  height: 57,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: MyColor.white,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipOval(
                        child: Image.asset(Assets.imagesHandHold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _AnimatedSlideToRight extends StatefulWidget {
  final Widget child;
  final bool isPlay;

  const _AnimatedSlideToRight({
    required this.child,
    required this.isPlay
  });

  @override
  _AnimatedSlideToRightState createState() => _AnimatedSlideToRightState();
}

class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlay) _controller.forward(from: 0);
    return SlideTransition(
      position: Tween(
          begin: const Offset(-1, 0),
          end: const Offset(1, 0)
      ).animate(
          CurvedAnimation(curve: Curves.easeOutQuad, parent: _controller)
      ),
      child: widget.child,
    );
  }
}
