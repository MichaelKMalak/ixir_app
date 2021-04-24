import 'package:logging/logging.dart';

class LoggerProvider {
  static void logFine(String id, String message) {
    final log = Logger(id);
    log.fine(message);
  }
}
