
import 'package:flutter/material.dart';

enum PaddingState {
  noPadding,
  defaultPadding
}

class BaseScaffold extends StatelessWidget {

  Widget? appBar;
  Widget body;
  bool? resizeToAvoidBottomInset;
  Function()? onPressedAosBackButton;
  BottomNavigationBar? bottomNavigationBar;
  Color? backgroundColor;
  PaddingState? paddingState;

  BaseScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.resizeToAvoidBottomInset,
    this.onPressedAosBackButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.paddingState,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(onPressedAosBackButton != null) {
          onPressedAosBackButton!();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
        bottomNavigationBar: bottomNavigationBar,
        body: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: true,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                children: [
                  if (appBar != null) appBar!,
                  Expanded(
                    child: Container(
                        margin: setPaddingState(),
                        child: body
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets setPaddingState() {
    if (paddingState == PaddingState.noPadding) {
      return const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0);
    } else {
      return const EdgeInsets.only(top: 4, left: 24, right: 24, bottom: 14);
    }
  }
}
