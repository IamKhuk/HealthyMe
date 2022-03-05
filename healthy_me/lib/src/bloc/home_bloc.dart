import 'package:healthy_me/src/model/api/doctors_list_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  Repository _repository = Repository();

  final _infoDocFetcher = PublishSubject<DoctorsListModel>();

  Stream<DoctorsListModel> get getDocs => _infoDocFetcher.stream;

  fetchDocList(
    String text,
    int regionId,
    int cityId,
  ) async {
    var response = await _repository.fetchDocList(text, regionId, cityId);
    if (response.isSuccess) {
      DoctorsListModel result = DoctorsListModel.fromJson(response.result);
      _infoDocFetcher.sink.add(result);
    }
  }

  dispose() {
    _infoDocFetcher.close();
  }
}

final blocProfile = HomeBloc();
