
import 'package:get/get.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/screens/home/home_screen.dart';
import 'package:tmtt/src/screens/splash_screen.dart';

class BaseGetPage extends GetPage {

  BaseGetPage({
    required super.name,
    required super.page,
    super.binding,
    super.arguments,
    super.transition = Transition.fadeIn,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.preventDuplicates = true,
  });
}

class PageName {
  static const String splash = '/splash';
  static const String home   = '/home';
}

List<BaseGetPage> kGetPages = [
  BaseGetPage(
    name: PageName.splash,
    page: () => SplashScreen(),
  ),
  BaseGetPage(
    name: PageName.home,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),

];