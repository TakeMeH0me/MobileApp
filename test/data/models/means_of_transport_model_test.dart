import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:take_me_home/data/models/means_of_transport_model.dart';
import 'package:take_me_home/domain/entities/means_of_transport_entity.dart';

void main() {
  final tMeansOfTransportModel = MeansOfTransportModel(
    name: 'test',
    departureTime: TimeOfDay.now(),
    isCancelled: false,
    delayInMinutes: 0,
  );

  test(
    'Should be a subclass of MeansOfTransportEntity.',
    () async {
      expect(tMeansOfTransportModel, isA<MeansOfTransportEntity>());
    },
  );

  group('fromPlainText', () {
    test(
      'Should return a valid model when the input is "12:00\ntest\nno".',
      () async {
        // arrange
        const List<String> input = ['12:00', 'test', 'no'];
        const expected = MeansOfTransportModel(
          name: 'test',
          departureTime: TimeOfDay(hour: 12, minute: 0),
          isCancelled: false,
          delayInMinutes: 0,
        );

        // act
        final actual = MeansOfTransportModel.fromPlainText(input);

        // assert
        expect(actual, expected);
      },
    );

    test(
      'Should return a valid model when the input is "12:00\ntest\ncancel".',
      () async {
        // arrange
        const List<String> input = ['12:00', 'test', 'cancel'];
        const expected = MeansOfTransportModel(
          name: 'test',
          departureTime: TimeOfDay(hour: 12, minute: 0),
          isCancelled: true,
          delayInMinutes: 0,
        );

        // act
        final actual = MeansOfTransportModel.fromPlainText(input);

        // assert
        expect(actual, expected);
      },
    );

    test(
      'Should return a valid model when the input is "12:00\ntest\n+ 5".',
      () async {
        // arrange
        const List<String> input = ['12:00', 'test', '+ 5'];
        const expected = MeansOfTransportModel(
          name: 'test',
          departureTime: TimeOfDay(hour: 12, minute: 0),
          isCancelled: false,
          delayInMinutes: 5,
        );

        // act
        final actual = MeansOfTransportModel.fromPlainText(input);

        // assert
        expect(actual, expected);
      },
    );

    test(
      'Should return a valid model when the input is "12:00\ntest\n0".',
      () async {
        // arrange
        const List<String> input = ['12:00', 'test', '0'];
        const expected = MeansOfTransportModel(
          name: 'test',
          departureTime: TimeOfDay(hour: 12, minute: 0),
          isCancelled: false,
          delayInMinutes: 0,
        );

        // act
        final actual = MeansOfTransportModel.fromPlainText(input);

        // assert
        expect(actual, expected);
      },
    );
  });
}
