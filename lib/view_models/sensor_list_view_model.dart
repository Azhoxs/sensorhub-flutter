import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/sensor_repository.dart';
import 'async_state.dart';

class SensorListViewModel extends ChangeNotifier {
  SensorListViewModel({required SensorRepository repository})
    : _repository = repository;

  final SensorRepository _repository;

  AsyncState<Sensor> _state = const Loading<Sensor>();

  AsyncState<Sensor> get state => _state;

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }

  Future<void> load() async {
    _setState(const Loading<Sensor>());

    try {
      final sensors = await _repository.fetchAll();
      _setState(Content<Sensor>(sensors));
    } catch (error) {
      _setState(Failure<Sensor>(error.toString()));
    }
  }
}
