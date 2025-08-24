import 'package:flutter_test/flutter_test.dart';
import 'package:nest/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('TicketScanningViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
