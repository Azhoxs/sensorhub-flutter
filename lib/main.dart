import 'package:flutter/material.dart';

import 'repositories/fake_sensor_repository.dart';
import 'router.dart';
import 'view_models/sensor_list_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = FakeSensorRepository();
  final viewModel = SensorListViewModel(repository: repository);

  await viewModel.load();

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
