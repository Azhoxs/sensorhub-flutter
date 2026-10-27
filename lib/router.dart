import 'package:go_router/go_router.dart';

import 'models/sensor.dart';
import 'pages/sensor_detail_page.dart';
import 'pages/sensor_list_page.dart';
import 'view_models/sensor_list_view_model.dart';

GoRouter createRouter(
  SensorListViewModel viewModel, {
  String initialLocation = '/',
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => SensorListPage(viewModel: viewModel),
      ),
      GoRoute(
        path: '/sensor/:id',
        builder: (context, state) {
          final extra = state.extra;
          return SensorDetailPage(
            sensorId: state.pathParameters['id']!,
            viewModel: viewModel,
            sensor: extra is Sensor ? extra : null,
          );
        },
      ),
    ],
  );
}
