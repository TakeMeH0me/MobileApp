import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:take_me_home/core/error/failure.dart';
import 'package:take_me_home/domain/entities/home_entity.dart';
import 'package:take_me_home/domain/entities/station_entity.dart';
import 'package:take_me_home/domain/repository/home_repository.dart';
import 'package:take_me_home/presentation/bloc/home/home_bloc.dart';
import 'package:take_me_home/presentation/pages/pages.dart';
import 'package:take_me_home/presentation/router/app_router.dart';
import 'package:take_me_home/presentation/router/args/create_or_edit_home_args.dart';
import 'package:take_me_home/presentation/router/args/show_way_to_home_args.dart';
import 'package:take_me_home/presentation/widgets/widgets.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class MockAppRouter extends Mock implements AppRouter {}

class FakeRouteSettings extends Fake implements RouteSettings {}

void main() {
  late MockHomeRepository mockHomeRepository;
  late MockAppRouter appRouter;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    appRouter = MockAppRouter();
  });

  const tHomeEntity = HomeEntity(
    id: '1',
    name: 'name',
    city: 'city',
    mainStation: StationEntity(
      id: '1',
      name: 'stationName',
    ),
    postcode: '12345',
    street: 'street',
    streetNumber: 'streetNumber',
  );

  setUpAll(() {
    registerFallbackValue(tHomeEntity);
    registerFallbackValue(FakeRouteSettings());
  });

  Widget createWidgetUnderTest() {
    return BlocProvider(
      create: (context) => HomeBloc(
        homeRepository: mockHomeRepository,
      ),
      child: MaterialApp(
        onGenerateRoute: (settings) => appRouter.onGenerateRoute(settings),
        home: const Scaffold(
          body: ShowHomesPage(),
        ),
      ),
    );
  }

  group('Displaying list', () {
    testWidgets('Shows a list of homes when data is available',
        (WidgetTester tester) async {
      when(() => mockHomeRepository.getAllHomes()).thenAnswer(
        (_) async => Right(Stream.value(
          [tHomeEntity, tHomeEntity],
        )),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Allow for data fetching and UI updates

      expect(find.byType(HomeButton), findsNWidgets(2));
    });

    testWidgets('Shows message when no homes are available',
        (WidgetTester tester) async {
      when(() => mockHomeRepository.getAllHomes()).thenAnswer(
        (_) async => Right(Stream.value([])),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('No homes created yet. Create one!'), findsOneWidget);
    });

    testWidgets('Shows error message on error', (WidgetTester tester) async {
      when(() => mockHomeRepository.getAllHomes()).thenAnswer(
        (_) async => Left(APIFailure()),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(Duration.zero); // Allow for data fetching

      expect(find.byType(HomeButton), findsNothing);
    });

    testWidgets('Triggers delete event on swipe left',
        (WidgetTester tester) async {
      when(() => mockHomeRepository.getAllHomes()).thenAnswer(
        (_) async => Right(Stream.value([tHomeEntity])),
      );
      when(() => mockHomeRepository.deleteHome(any())).thenAnswer(
        (_) async => const Right(null),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final dismissibleFinder = find.byType(Dismissible);
      expect(dismissibleFinder, findsOneWidget);

      await tester.drag(
        dismissibleFinder,
        const Offset(-500, 0),
      ); // Simulate swipe left
      await tester.pumpAndSettle();

      verify(() => mockHomeRepository.deleteHome(tHomeEntity)).called(1);
      expect(find.byType(HomeButton), findsNothing);
    });
  });

  group('Navigation to other screens', () {
    testWidgets('Navigates to ShowWayToHomePage on home button tap',
        (WidgetTester tester) async {
      when(() => mockHomeRepository.getAllHomes()).thenAnswer(
        (_) async => Right(Stream.value([tHomeEntity])),
      );
      when(() => appRouter.onGenerateRoute(any())).thenReturn(
        MaterialPageRoute(
          builder: (_) => const ShowWayToHomePage(home: tHomeEntity),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final homeButtonFinder = find.byType(HomeButton);
      expect(homeButtonFinder, findsOneWidget);

      await tester.tap(homeButtonFinder);
      
      final capturedArguments =
          verify(() => appRouter.onGenerateRoute(captureAny()))
              .captured
              .single
              .arguments as ShowWayToHomeArgs;
      expect(capturedArguments.home, tHomeEntity);
    });

    testWidgets('Navigates to CreateOrEditHomePage on edit button tap',
        (WidgetTester tester) async {
      when(() => mockHomeRepository.getAllHomes()).thenAnswer(
        (_) async => Right(Stream.value([tHomeEntity])),
      );
      when(() => appRouter.onGenerateRoute(any())).thenReturn(
        MaterialPageRoute(
          builder: (_) => const CreateOrEditHomePage(
            home: tHomeEntity,
            isNewHome: false,
          ),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final editButtonFinder = find.byType(IconButton);
      expect(editButtonFinder, findsOneWidget);

      await tester.tap(editButtonFinder);

      final capturedArguments =
          verify(() => appRouter.onGenerateRoute(captureAny()))
              .captured
              .single
              .arguments as CreateOrEditHomeArgs;

      expect(capturedArguments.home, tHomeEntity);
      expect(capturedArguments.isNewHome, false);
    });
  });
}
