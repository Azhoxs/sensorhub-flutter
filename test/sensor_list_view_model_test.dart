import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/repositories/fake_sensor_repository.dart';
import 'package:flutter_application_1/view_models/async_state.dart';
import 'package:flutter_application_1/view_models/sensor_list_view_model.dart';

void main() {
  test('load() publie Loading puis Content, sans Provider ni widget', () async {
    final repository = FakeSensorRepository(latency: Duration.zero);
    final viewModel = SensorListViewModel(repository: repository);

    expect(viewModel.state, isA<Loading<dynamic>>());

    final observedStates = <AsyncState<dynamic>>[];
    viewModel.addListener(() => observedStates.add(viewModel.state));

    await viewModel.load();

    expect(observedStates.length, 2);
    expect(observedStates.first, isA<Loading<dynamic>>());
    expect(observedStates.last, isA<Content<dynamic>>());
  });

  test('load() publie Failure si le repository échoue', () async {
    final repository = FakeSensorRepository(
      latency: Duration.zero,
      shouldFail: true,
    );
    final viewModel = SensorListViewModel(repository: repository);

    final observedStates = <AsyncState<dynamic>>[];
    viewModel.addListener(() => observedStates.add(viewModel.state));

    await viewModel.load();

    expect(observedStates.last, isA<Failure<dynamic>>());
  });
}
