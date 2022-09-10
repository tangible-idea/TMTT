import 'package:logger/logger.dart';

class Log {
  static final _logger = Logger(
    filter: null, // only log in debug mode
    output: null, // send everything to console
    printer: PrettyPrinter(
      colors: true,
      printEmojis: false,
      printTime: false,
    ),
  );

  static void d(dynamic message) {
    _logger.d(message);
    // _logger.d('Log message with 2 methods');
    // _logger.i('logger Info message', 'Test Error');
    // _logger.w('Just a warning!');
    // _logger.e('Error! Something bad happened', 'Test Error');
    // _logger.v({'key': 5, 'value': 'something'});
  }
}
