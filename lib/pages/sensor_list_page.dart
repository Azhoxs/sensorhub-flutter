import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../view_models/async_state.dart';
import '../view_models/sensor_list_view_model.dart';
import '../widgets/sensor_card.dart';

class SensorListPage extends StatefulWidget {
  const SensorListPage({super.key, required this.viewModel});

  final SensorListViewModel viewModel;

  @override
  State<SensorListPage> createState() => _SensorListPageState();
}

class _SensorListPageState extends State<SensorListPage> {
  SensorListViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text('SensorHub'),
          actions: [
            IconButton(
              tooltip: 'Actualiser',
              icon: const Icon(Icons.refresh),
              onPressed: viewModel.isLoading ? null : viewModel.load,
            ),
          ],
        ),
        body: Column(
          children: [
            _RefreshStatus(viewModel: viewModel),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return switch (viewModel.state) {
      Loading() => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Actualisation en cours…'),
          ],
        ),
      ),
      Failure(:final message) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: viewModel.isLoading ? null : viewModel.load,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
      Content(values: []) => const Center(child: Text('Aucun capteur')),
      Content(:final values) => ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: values.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final sensor = values[index];
          return SensorCard(
            sensor: sensor,
            onTap: () => context.push('/sensor/${sensor.id}', extra: sensor),
          );
        },
      ),
    };
  }
}

class _RefreshStatus extends StatelessWidget {
  const _RefreshStatus({required this.viewModel});

  final SensorListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final stale = viewModel.isStale;
    final color = stale ? Colors.orange.shade800 : Colors.black87;

    return Container(
      width: double.infinity,
      color: stale ? Colors.orange.shade50 : Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(
            stale ? Icons.warning_amber : Icons.schedule,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              stale
                  ? '${viewModel.lastRefreshLabel} · données anciennes'
                  : viewModel.lastRefreshLabel,
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
