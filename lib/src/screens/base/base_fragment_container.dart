
import 'package:flutter/material.dart';

class FragmentContainer extends StatelessWidget {

  Widget child;

  FragmentContainer({
    Key? key,
    required this.child,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: child,
      ),
    );
  }
}