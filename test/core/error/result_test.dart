import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/core/error/failures.dart';
import 'package:tic_tac_toe/core/error/result.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('isSuccess returns true', () {
        const result = Success<int>(42);
        expect(result.isSuccess, true);
        expect(result.isFailure, false);
      });

      test('value returns the data', () {
        const result = Success<String>('test');
        expect(result.value, 'test');
      });

      test('failure throws StateError', () {
        const result = Success<int>(42);
        expect(() => result.failure, throwsStateError);
      });

      test('map transforms the data', () {
        const result = Success<int>(10);
        final mapped = result.map((data) => data * 2);

        expect(mapped.isSuccess, true);
        expect(mapped.value, 20);
      });

      test('fold calls onSuccess', () {
        const result = Success<int>(10);
        final folded = result.fold(
          onSuccess: (data) => 'Success: $data',
          onFailure: (failure) => 'Failure: ${failure.message}',
        );

        expect(folded, 'Success: 10');
      });

      test('getOrElse returns value', () {
        const result = Success<int>(42);
        expect(result.getOrElse(0), 42);
      });
    });

    group('Fail', () {
      test('isFailure returns true', () {
        const result = Fail<int>(StorageFailure('test'));
        expect(result.isFailure, true);
        expect(result.isSuccess, false);
      });

      test('failure returns the failure', () {
        const failure = StorageFailure('test');
        const result = Fail<int>(failure);
        expect(result.failure, failure);
      });

      test('value throws StateError', () {
        const result = Fail<int>(StorageFailure('test'));
        expect(() => result.value, throwsStateError);
      });

      test('map preserves the failure', () {
        const result = Fail<int>(StorageFailure('test'));
        final mapped = result.map((data) => data * 2);

        expect(mapped.isFailure, true);
        expect(mapped.failure.message, 'test');
      });

      test('fold calls onFailure', () {
        const result = Fail<int>(StorageFailure('error'));
        final folded = result.fold(
          onSuccess: (data) => 'Success: $data',
          onFailure: (failure) => 'Failure: ${failure.message}',
        );

        expect(folded, 'Failure: error');
      });

      test('getOrElse returns default value', () {
        const result = Fail<int>(StorageFailure('test'));
        expect(result.getOrElse(0), 0);
      });
    });
  });
}
