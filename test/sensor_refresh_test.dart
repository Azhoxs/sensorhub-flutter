import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/models/sensor.dart';
import 'package:flutter_application_1/pages/sensor_list_page.dart';
import 'package:flutter_application_1/repositories/fake_sensor_repository.dart';
import 'package:flutter_application_1/view_models/async_state.dart';
import 'package:flutter_application_1/view_models/sensor_list_view_model.dart';

void main() {
  group('Nouvelle tentative', () {
    test('échec puis succès avec la même instance du ViewModel', () async {
      final repository = FakeSensorRepository(
        latency: Duration.zero,
        failFirstCalls: 1,
      );
      final viewModel = SensorListViewModel(repository: repository);

      await viewModel.load();
      expect(viewModel.state, isA<Failure<dynamic>>());

      await viewModel.load();
      expect(viewModel.state, isA<Content<dynamic>>());
      expect(repository.fetchCount, 2);
    });
  });

  group('Actualisations répétées', () {
    test('plusieurs appels rapides ne lancent qu\'un seul chargement', () async {
      final repository = FakeSensorRepository(
        latency: const Duration(milliseconds: 100),
      );
      final viewModel = SensorListViewModel(repository: repository);

      final calls = [viewModel.load(), viewModel.load(), viewModel.load()];
      expect(viewModel.isLoading, isTrue);
      await Future.wait(calls);

      expect(repository.fetchCount, 1);
      expect(viewModel.isLoading, isFalse);
    });

    test('une nouvelle actualisation est possible après la fin', () async {
      final repository = FakeSensorRepository(
        latency: const Duration(milliseconds: 10),
      );
      final viewModel = SensorListViewModel(repository: repository);

      await viewModel.load();
      await viewModel.load();

      expect(repository.fetchCount, 2);
    });
  });

  group('Dernière actualisation réussie', () {
    test('absente avant un succès, mise à jour à chaque succès', () async {
      var now = DateTime(2026, 1, 1, 10, 0, 0);
      final viewModel = SensorListViewModel(
        repository: FakeSensorRepository(latency: Duration.zero),
        now: () => now,
      );

      expect(viewModel.lastRefreshLabel, 'Aucune actualisation réussie');

      await viewModel.load();
      expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 10:00:00');

      now = DateTime(2026, 1, 1, 10, 5, 7);
      await viewModel.load();
      expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 10:05:07');

      viewModel.dispose();
    });

    test('une erreur sans succès préalable reste « aucune »', () async {
      final viewModel = SensorListViewModel(
        repository: FakeSensorRepository(
          latency: Duration.zero,
          shouldFail: true,
        ),
      );

      await viewModel.load();

      expect(viewModel.state, isA<Failure<dynamic>>());
      expect(viewModel.lastRefreshLabel, 'Aucune actualisation réussie');
    });

    test('une erreur après un succès garde l\'heure du dernier succès', () async {
      var now = DateTime(2026, 1, 1, 10, 0, 0);
      // Le premier appel réussit, le second échoue.
      final repository = _SucceedThenFailRepository();
      final viewModel = SensorListViewModel(
        repository: repository,
        now: () => now,
      );

      await viewModel.load();
      now = DateTime(2026, 1, 1, 10, 3, 0);
      await viewModel.load();

      expect(viewModel.state, isA<Failure<dynamic>>());
      expect(viewModel.lastRefreshLabel, 'Dernière actualisation : 10:00:00');

      viewModel.dispose();
    });
  });

  group('Données anciennes', () {
    test('devient ancienne après le seuil, fraîche après un succès', () async {
      var now = DateTime(2026, 1, 1, 10, 0, 0);
      final viewModel = SensorListViewModel(
        repository: FakeSensorRepository(latency: Duration.zero),
        staleAfter: const Duration(seconds: 30),
        now: () => now,
      );

      expect(viewModel.isStale, isFalse);

      await viewModel.load();
      expect(viewModel.isStale, isFalse);

      now = now.add(const Duration(seconds: 31));
      expect(viewModel.isStale, isTrue);

      await viewModel.load();
      expect(viewModel.isStale, isFalse);

      viewModel.dispose();
    });
  });

  testWidgets('Réessayer relance le chargement avec le même ViewModel', (
    tester,
  ) async {
    final repository = FakeSensorRepository(
      latency: const Duration(milliseconds: 100),
      failFirstCalls: 1,
    );
    final viewModel = SensorListViewModel(repository: repository);

    await tester.pumpWidget(
      MaterialApp(home: SensorListPage(viewModel: viewModel)),
    );

    await tester.pump();
    expect(find.text('Actualisation en cours…'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 150));
    await tester.pump();
    expect(find.text('Réessayer'), findsOneWidget);
    expect(find.text('Aucune actualisation réussie'), findsOneWidget);

    await tester.tap(find.text('Réessayer'));
    await tester.pump(const Duration(milliseconds: 150));
    await tester.pump();

    expect(find.text('Salon'), findsOneWidget);
    expect(find.textContaining('Dernière actualisation'), findsOneWidget);
    expect(repository.fetchCount, 2);

    await tester.pumpWidget(const SizedBox());
    viewModel.dispose();
  });
}

class _SucceedThenFailRepository extends FakeSensorRepository {
  _SucceedThenFailRepository() : super(latency: Duration.zero);

  int _calls = 0;

  @override
  Future<List<Sensor>> fetchAll() async {
    _calls++;
    if (_calls > 1) throw Exception('Erreur');
    return super.fetchAll();
  }
}
