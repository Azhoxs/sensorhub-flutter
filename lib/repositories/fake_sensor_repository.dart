import '../models/sensor.dart';
import 'sensor_repository.dart';

class FakeSensorRepository implements SensorRepository {
  FakeSensorRepository({
    this.latency = const Duration(seconds: 1),
    this.shouldFail = false,
  });

  final Duration latency;
  final bool shouldFail;

  final List<Sensor> _sensors = [
    Sensor(
      id: '1',
      nom: 'Salon',
      temperature: 21.8,
      humidite: 45,
      enLigne: true,
      batterie: 82,
      etat: 'OK',
      derniereMesure: 'Il y a 2 min',
    ),
    Sensor(
      id: '2',
      nom: 'Garage',
      temperature: 29.6,
      humidite: 61,
      enLigne: true,
      batterie: 34,
      etat: 'Alerte',
      derniereMesure: 'Il y a 12 min',
    ),
    Sensor(
      id: '3',
      nom: 'Cave',
      temperature: 14.2,
      humidite: 78,
      enLigne: false,
      batterie: 9,
      etat: 'Hors ligne',
      derniereMesure: 'Il y a 3 h',
    ),
  ];

  @override
  Future<List<Sensor>> fetchAll() async {
    await Future.delayed(latency);

    if (shouldFail) {
      throw Exception('Impossible de récupérer les capteurs');
    }

    return List.unmodifiable(_sensors);
  }
}
