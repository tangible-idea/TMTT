
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmtt/generated/assets.dart';
import 'package:tmtt/src/resources/styles/my_color.dart';
import 'package:tmtt/src/resources/styles/txt_style.dart';
import 'package:tmtt/src/widgets/app_space.dart';
import 'package:tmtt/src/widgets/plain_text.dart';

class InboxItem extends StatelessWidget {

  String tag = '';
  String data = '';
  bool isRead = false;
  bool useMargin = false;
  bool isPlay = false;
  String? profileURL;

  InboxItem({
    super.key,
    this.tag = '',
    this.data = '',
    this.isRead = false,
    this.useMargin = true,
    this.isPlay = false,
    this.profileURL,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          margin: useMargin ? const EdgeInsets.symmetric(horizontal: 18, vertical: 3) : null,
          decoration: BoxDecoration(
            color: isRead ? MyColor.kGrayedPrimary  : MyColor.kPrimary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: isRead ?  Image.asset(Assets.imagesArrived) : Image.asset(Assets.imagesAnonymous),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(Assets.imagesAirplaneLine, fit: BoxFit.cover),
                        isPlay ? airplaneAnim() : airplaneStatic(),
                      ],
                    ),
                  ),
                ),

                Stack(children: [
                  profileURL != "" ? SizedBox(width: 60, height: 60,
                      child: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(profileURL ?? ""),
                        radius: 35
                    ),
                  ): ClipOval(
                    child: Image.asset(Assets.imagesHello, width: 70,),
                  ),

                  // TODO : 나중에 시간되면 추가.
                  // isRead ?
                  // Positioned(
                  //   left: 40,
                  //   top: -10,
                  //   child: SvgPicture.asset(Assets.imagesCheckbox)) : const SizedBox()
                ],),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget airplaneAnim() {
    return _AnimatedSlideToRight(
      isPlay: isPlay,
      child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(Assets.imagesAirplane, fit: BoxFit.cover),
            Positioned(
              top: 16,
              child: PlainText(
                text: data,
                style: MyTextStyle.body1Bold.copyWith(
                  fontSize: 10,
                  color: MyColor.kPrimary,
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget airplaneStatic() {
    return Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(Assets.imagesAirplane, fit: BoxFit.cover),
          Positioned(
            top: 16,
            child: PlainText(
              text: data,
              style: MyTextStyle.body1Bold.copyWith(
                fontSize: 10,
                color: MyColor.kPrimary,
              ),
            ),
          ),
        ]
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

class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.isPlay) {
      _controller.forward(from: 0);
      _controller2.forward(from: 0);
    }
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween(
            begin: const Offset(-0.75, 0),
            end: const Offset(0, 0)
        ).animate(
            CurvedAnimation(curve: Curves.easeOutQuad, parent: _controller)
        ),
        child: widget.child,
      ),
    );
  }
}
