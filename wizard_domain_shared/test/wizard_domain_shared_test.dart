import 'package:flutter_test/flutter_test.dart';

import 'package:wizard_domain_shared/result.dart';

void main() {
  test('a success type gives back its value accurately', () {
    const success = Success(5);
    expect(success.value, 5);
  });

  test('a failure type gives back its value accurately', () {
    final failure = Failure(Exception('something went wrong'));
    expect(failure.exception.toString(), 'Exception: something went wrong');
  });
}
