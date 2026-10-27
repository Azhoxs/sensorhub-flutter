import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/repositories/fake_sensor_repository.dart';
import 'package:flutter_application_1/router.dart';
import 'package:flutter_application_1/view_models/sensor_list_view_model.dart';

Future<void> _pumpApp(
  WidgetTester tester,
  SensorListViewModel viewModel, {
  String initialLocation = '/',
}) {
  return tester.pumpWidget(
    MaterialApp.router(
      routerConfig: createRouter(viewModel, initialLocation: initialLocation),
    ),
  );
}

Future<void> _closeApp(
  WidgetTester tester,
  SensorListViewModel viewModel,
) async {
  await tester.pumpWidget(const SizedBox());
  viewModel.dispose();
}

void main() {
  testWidgets('lien direct (notification) : charge puis affiche le détail', (
    tester,
  ) async {
    final repository = FakeSensorRepository(
      latency: const Duration(milliseconds: 100),
    );
    final viewModel = SensorListViewModel(repository: repository);

    await _pumpApp(tester, viewModel, initialLocation: '/sensor/2');
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 150));
    await tester.pump();

    expect(find.text('Capteur du garage'), findsOneWidget);
    expect(find.text('Humidité'), findsOneWidget);
    expect(repository.fetchCount, 1);

    await _closeApp(tester, viewModel);
  });

  testWidgets('lien direct avec un identifiant inconnu', (tester) async {
    final viewModel = SensorListViewModel(
      repository: FakeSensorRepository(
        latency: const Duration(milliseconds: 50),
      ),
    );

    await _pumpApp(tester, viewModel, initialLocation: '/sensor/99');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();

    expect(find.text('Capteur introuvable'), findsOneWidget);

    await _closeApp(tester, viewModel);
  });

  testWidgets('lien direct : erreur de chargement puis Réessayer', (
    tester,
  ) async {
    final repository = FakeSensorRepository(
      latency: const Duration(milliseconds: 50),
      failFirstCalls: 1,
    );
    final viewModel = SensorListViewModel(repository: repository);

    await _pumpApp(tester, viewModel, initialLocation: '/sensor/1');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();
    expect(find.text('Réessayer'), findsOneWidget);

    await tester.tap(find.text('Réessayer'));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump();

    expect(find.text('Capteur du salon'), findsOneWidget);

    await _closeApp(tester, viewModel);
  });

  testWidgets('clic dans la liste : le détail utilise extra, sans recharger', (
    tester,
  ) async {
    final repository = FakeSensorRepository(latency: Duration.zero);
    final viewModel = SensorListViewModel(repository: repository);

    await _pumpApp(tester, viewModel);
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pump();

    await tester.tap(find.text('Garage'));
    await tester.pumpAndSettle();

    expect(find.text('Capteur du garage'), findsOneWidget);
    expect(repository.fetchCount, 1);

    await _closeApp(tester, viewModel);
  });
}
