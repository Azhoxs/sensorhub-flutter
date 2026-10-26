import 'package:flutter/material.dart';

import '../models/sensor.dart';

class SensorDetailPage extends StatelessWidget {
  final Sensor sensor;

  const SensorDetailPage({super.key, required this.sensor});

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
