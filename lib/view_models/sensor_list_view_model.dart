import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/sensor.dart';
import '../repositories/sensor_repository.dart';
import 'async_state.dart';

class SensorListViewModel extends ChangeNotifier {
  SensorListViewModel({
    required SensorRepository repository,
    this.staleAfter = const Duration(seconds: 30),
    DateTime Function() now = DateTime.now,
  }) : _repository = repository,
       _now = now;

  final SensorRepository _repository;
  final DateTime Function() _now;

  /// Âge à partir duquel la dernière actualisation réussie est jugée ancienne.
  final Duration staleAfter;

  AsyncState<Sensor> _state = const Loading<Sensor>();
  bool _isLoading = false;
  DateTime? _lastSuccessAt;
  Timer? _staleTimer;

  AsyncState<Sensor> get state => _state;

  /// Vrai tant qu'un chargement est en cours : la View s'en sert pour
  /// désactiver l'actualisation.
  bool get isLoading => _isLoading;

  /// Texte de la dernière actualisation réussie, prêt à être affiché.
  String get lastRefreshLabel {
    final at = _lastSuccessAt;
    if (at == null) return 'Aucune actualisation réussie';
    return 'Dernière actualisation : ${_formatTime(at)}';
  }

  /// Vrai si le dernier succès date de plus de [staleAfter].
  bool get isStale {
    final at = _lastSuccessAt;
    if (at == null) return false;
    return _now().difference(at) > staleAfter;
  }

  void _setState(AsyncState<Sensor> value) {
    _state = value;
    notifyListeners();
  }

  Future<void> load() async {
    if (_isLoading) return;

    _isLoading = true;
    _setState(const Loading<Sensor>());

    AsyncState<Sensor> result;
    try {
      final sensors = await _repository.fetchAll();
      _lastSuccessAt = _now();
      _scheduleStaleNotification();
      result = Content<Sensor>(sensors);
    } catch (error) {
      result = Failure<Sensor>(error.toString());
    }

    _isLoading = false;
    _setState(result);
  }

  void _scheduleStaleNotification() {
    _staleTimer?.cancel();
    _staleTimer = Timer(staleAfter + const Duration(milliseconds: 50), () {
      notifyListeners();
    });
  }

  String _formatTime(DateTime date) {
    String two(int value) => value.toString().padLeft(2, '0');
    return '${two(date.hour)}:${two(date.minute)}:${two(date.second)}';
  }

  @override
  void dispose() {
    _staleTimer?.cancel();
    super.dispose();
  }
}
