import 'package:flutter/material.dart';

import '../models/sensor.dart';
import '../view_models/async_state.dart';
import '../view_models/sensor_list_view_model.dart';

/// Détail d'un capteur.
///
/// Depuis la liste, le capteur arrive directement via `extra`. Depuis une
/// notification (lien direct), seul l'identifiant est connu : la page demande
/// alors le chargement au ViewModel et retrouve le capteur.
class SensorDetailPage extends StatefulWidget {
  const SensorDetailPage({
    super.key,
    required this.sensorId,
    required this.viewModel,
    this.sensor,
  });

  final String sensorId;
  final SensorListViewModel viewModel;
  final Sensor? sensor;

  @override
  State<SensorDetailPage> createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends State<SensorDetailPage> {
  @override
  void initState() {
    super.initState();
    if (widget.sensor == null && widget.viewModel.state is! Content<Sensor>) {
      widget.viewModel.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sensor = widget.sensor;
    if (sensor != null) return _SensorDetailView(sensor: sensor);

    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) => switch (widget.viewModel.state) {
        Loading() => const _DetailScaffold(
          child: Center(child: CircularProgressIndicator()),
        ),
        Failure(:final message) => _DetailScaffold(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: widget.viewModel.isLoading
                      ? null
                      : widget.viewModel.load,
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        Content(:final values) => _contentFor(values),
      },
    );
  }

  Widget _contentFor(List<Sensor> values) {
    final found = values.where((s) => s.id == widget.sensorId).firstOrNull;
    if (found == null) {
      return const _DetailScaffold(
        child: Center(child: Text('Capteur introuvable')),
      );
    }
    return _SensorDetailView(sensor: found);
  }
}

class _DetailScaffold extends StatelessWidget {
  const _DetailScaffold({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Capteur')), body: child);
  }
}

class _SensorDetailView extends StatelessWidget {
  final Sensor sensor;

  const _SensorDetailView({required this.sensor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capteur du ${sensor.nom.toLowerCase()}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 12,
                  color: sensor.enLigne ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  sensor.enLigne ? 'En ligne' : 'Hors ligne',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _DetailRow(label: 'Température', value: '${sensor.temperature}°C'),
            const SizedBox(height: 8),
            _DetailRow(label: 'Humidité', value: '${sensor.humidite} %'),
            const SizedBox(height: 8),
            _DetailRow(label: 'Batterie', value: '${sensor.batterie} %'),
            const SizedBox(height: 24),
            _DetailRow(label: 'État', value: sensor.etat),
            const SizedBox(height: 24),
            const Text('Dernière mesure', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(sensor.derniereMesure, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 18)),
        Text(value, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
