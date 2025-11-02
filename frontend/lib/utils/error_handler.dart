import 'logger.dart';

class ErrorHandler {
  static void capture(Object error, [StackTrace? stack]) {
    logError('Unhandled error', error, stack);
  }
}
