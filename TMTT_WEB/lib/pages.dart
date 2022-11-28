
import 'package:get/get.dart';
import 'package:tmtt_web/write_message_controller.dart';
import 'package:tmtt_web/write_message_screen.dart';

import 'index_controller.dart';
import 'index_screen.dart';

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
  static const String writeMessage = '/:uid';
}

List<BaseGetPage> kGetPages = [
  BaseGetPage(
    name: PageName.index,
    binding: IndexBinding(),
    page: () => IndexScreen(),
  ),
  BaseGetPage(
    name: PageName.writeMessage,
    page: () => WriteMessageScreen(),
    binding: WriteMessageBinding(),
  ),
];