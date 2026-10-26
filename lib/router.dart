import 'package:go_router/go_router.dart';

import 'models/sensor.dart';
import 'pages/sensor_detail_page.dart';
import 'pages/sensor_list_page.dart';
import 'view_models/async_state.dart';
import 'view_models/sensor_list_view_model.dart';

GoRouter createRouter(SensorListViewModel viewModel) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SensorListPage(viewModel: viewModel),
      ),
      GoRoute(
        path: '/sensor/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final sensors = switch (viewModel.state) {
            Content(:final values) => values,
            _ => const <Sensor>[],
          };
          final Sensor sensor = sensors.firstWhere((s) => s.id == id);
          return SensorDetailPage(sensor: sensor);
        },
      ),
    ],
  );
}
