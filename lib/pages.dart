
import 'package:get/get.dart';
import 'package:tmtt/src/screens/home/home_controller.dart';
import 'package:tmtt/src/screens/home/home_base_screen.dart';
import 'package:tmtt/src/screens/inbox/inbox_controller.dart';
import 'package:tmtt/src/screens/inbox/inbox_screen.dart';
import 'package:tmtt/src/screens/index_controller.dart';
import 'package:tmtt/src/screens/index_screen.dart';
import 'package:tmtt/src/screens/privacy_policy/privacy_controller.dart';
import 'package:tmtt/src/screens/privacy_policy/privacy_screen.dart';
import 'package:tmtt/src/screens/privacy_policy/termsofuse_controller.dart';
import 'package:tmtt/src/screens/privacy_policy/termsofuse_screen.dart';
import 'package:tmtt/src/screens/register/create_slug_screen.dart';
import 'package:tmtt/src/screens/register/register_controller.dart';
import 'package:tmtt/src/screens/register/register_screen.dart';
import 'package:tmtt/src/screens/splash_screen.dart';
import 'package:tmtt/src/screens/write_message/write_message_controller.dart';
import 'package:tmtt/src/screens/write_message/write_message_screen.dart';

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
  static const String index        = '/'; // 여기에 tmtt 소개 웹사이트 페이지 넣으면 될듯
  static const String splash       = '/splash';
  static const String register     = '/register';
  static const String createslug   = '/createslug';
  static const String home         = '/home';
  static const String inbox        = '/inbox';
  static const String privacy      = '/privacy';
  static const String terms         = '/terms';
  static const String writeMessage = '/:uid';
}

List<BaseGetPage> kGetPages = [
  BaseGetPage(
    name: PageName.index,
    binding: IndexBinding(),
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
    name: PageName.createslug,
    page: () => CreateSlugScreen(),
    binding: RegisterBinding(),
  ),
  BaseGetPage(
    name: PageName.home,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  BaseGetPage(
    name: PageName.inbox,
    page: () => InboxScreen(),
    binding: InboxBinding(),
  ),
  BaseGetPage(
    name: PageName.privacy,
    page: () => PrivacyScreen(),
    binding: PrivacyBinding(),
  ),
  BaseGetPage(
    name: PageName.terms,
    page: () => TermsOfUseScreen(),
    binding: TermsOfUseBinding(),
  ),
  BaseGetPage(
    name: PageName.writeMessage,
    page: () => WriteMessageScreen(),
    binding: WriteMessageBinding(),
  ),
];