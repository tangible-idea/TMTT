
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {

  Widget? appBar;
  Widget body;
  bool? resizeToAvoidBottomInset;
  Function()? onPressedAosBackButton;
  BottomNavigationBar? bottomNavigationBar;

  BaseScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.resizeToAvoidBottomInset,
    this.onPressedAosBackButton,
    this.bottomNavigationBar
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
                        margin: const EdgeInsets.only(top: 4, left: 24, right: 24, bottom: 14),
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
}
