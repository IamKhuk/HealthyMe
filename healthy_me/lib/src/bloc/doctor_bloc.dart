import 'package:healthy_me/src/model/api/doctor_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DoctorBloc {
  Repository _repository = Repository();

  final _docDetailsFetcher = PublishSubject<DoctorApiModel>();

  Stream<DoctorApiModel> get getDocDetails => _docDetailsFetcher.stream;

  fetchDocList(int doctorId) async {
    var response = await _repository.fetchDocDetails(doctorId);
    if (response.isSuccess) {
      DoctorApiModel result = DoctorApiModel.fromJson(response.result);
      _docDetailsFetcher.sink.add(result);
    }
  }

  dispose() {
    _docDetailsFetcher.close();
  }
}

final blocDoctor = DoctorBloc();
