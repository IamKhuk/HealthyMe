import 'package:healthy_me/src/model/api/schedule_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleBloc {
  Repository _repository = Repository();

  final _schedulesFetcher = PublishSubject<ScheduleModel>();

  Stream<ScheduleModel> get getSchedules => _schedulesFetcher.stream;

  fetchDocList(String status) async {
    var response = await _repository.fetchScheduleGet(status);
    if (response.isSuccess) {
      ScheduleModel result = ScheduleModel.fromJson(response.result);
      _schedulesFetcher.sink.add(result);
    }
  }

  dispose() {
    _schedulesFetcher.close();
  }
}

final blocSchedule = ScheduleBloc();
