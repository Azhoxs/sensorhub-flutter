import 'package:flutter/material.dart';

import '../models/sensor.dart';

class SensorCard extends StatelessWidget {
  final Sensor sensor;
  final VoidCallback? onTap;

  const SensorCard({super.key, required this.sensor, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool horsLigne = !sensor.enLigne;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: horsLigne ? Colors.grey.shade200 : Colors.white,
          border: Border.all(color: horsLigne ? Colors.grey : Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sensor.nom,
                  style: TextStyle(
                    fontSize: 18,
                    color: horsLigne ? Colors.grey : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${sensor.temperature}° · ${sensor.humidite} %',
                  style: TextStyle(
                    fontSize: 14,
                    color: horsLigne ? Colors.grey : Colors.black87,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  horsLigne ? Icons.cloud_off : Icons.cloud_done,
                  size: 18,
                  color: horsLigne ? Colors.grey : Colors.green,
                ),
                const SizedBox(width: 6),
                Text(
                  horsLigne ? 'Hors ligne' : 'En ligne',
                  style: TextStyle(
                    color: horsLigne ? Colors.grey : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
