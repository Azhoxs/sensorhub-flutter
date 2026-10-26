import 'package:flutter/material.dart';

import 'repositories/fake_sensor_repository.dart';
import 'router.dart';
import 'view_models/sensor_list_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configuration de démonstration : réponse lente, premier chargement en
  // erreur, données jugées anciennes après 10 s (30 s par défaut).
  final repository = FakeSensorRepository(
    latency: const Duration(seconds: 3),
    failFirstCalls: 1,
  );
  final viewModel = SensorListViewModel(
    repository: repository,
    staleAfter: const Duration(seconds: 10),
  );

  runApp(MainApp(viewModel: viewModel));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.viewModel});

  final SensorListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: createRouter(viewModel));
  }
}
