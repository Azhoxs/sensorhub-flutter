import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_models/async_state.dart';
import '../view_models/sensor_list_view_model.dart';
import '../widgets/sensor_card.dart';

class SensorListPage extends StatelessWidget {
  const SensorListPage({super.key, required this.viewModel});

  final SensorListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SensorHub')),
      body: switch (viewModel.state) {
        Loading() => const Center(child: CircularProgressIndicator()),
        Failure(:final message) => Center(child: Text(message)),
        Content(values: []) => const Center(child: Text('Aucun capteur')),
        Content(:final values) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: values.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final sensor = values[index];
            return SensorCard(
              sensor: sensor,
              onTap: () => context.push('/sensor/${sensor.id}'),
            );
          },
        ),
      },
    );
  }
}
