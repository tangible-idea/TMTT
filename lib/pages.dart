
import 'package:get/get.dart';
import 'package:tmtt/src/screens/dynamic/ArticlePage.dart';
import 'package:tmtt/src/screens/dynamic/dynamic_user_controller.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/screens/home/home_base_screen.dart';
import 'package:tmtt/src/screens/index.dart';
import 'package:tmtt/src/screens/register/register_controller.dart';
import 'package:tmtt/src/screens/register/register_screen.dart';
import 'package:tmtt/src/screens/splash_screen.dart';

import 'src/screens/dynamic/dynamic_user_screen.dart';

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
  static const String index           = '/'; // 여기에 tmtt 소개 웹사이트 페이지 넣으면 될듯
  static const String splash          = '/splash';
  static const String register        = '/register';
  static const String home            = '/home';
  static const String overview        = '/overview';
  static const String dynamicUserPage = '/:uid';
}

List<BaseGetPage> kGetPages = [
  BaseGetPage(
    name: PageName.index,
    page: () => IndexScreen(),
  ),
  BaseGetPage(
    name: PageName.splash,
    page: () => SplashScreen(),
  ),
  BaseGetPage(
    name: PageName.register,
    page: () => RegisterScreen(),
    binding: RegisterBinding(),
  ),
  BaseGetPage(
    name: PageName.home,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  BaseGetPage(
    name: PageName.overview,
    page: () => OverviewPage(),
  ),
  BaseGetPage(
    name: PageName.dynamicUserPage,
    page: () => DynamicUserScreen(),
    binding: DynamicUserBinding(),
  ),

];