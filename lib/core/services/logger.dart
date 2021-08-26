import 'package:logger/logger.dart';

//You can use this instead of print so that we can track the progress
//of our app formally.

//to find different kinds of log visits:
//https://pub.dev/packages/logger

Logger getLogger(String className) {
  return Logger(printer: SimpleLogPrinter(className));
}

class SimpleLogPrinter extends LogPrinter {
  SimpleLogPrinter(this.className);
  final String className;

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    return [color!('$emoji $className - ${event.message}')];
  }
}
