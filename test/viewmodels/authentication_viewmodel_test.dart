import 'package:flutter_test/flutter_test.dart';
import 'package:book_my_clinic/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('AuthenticationViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}