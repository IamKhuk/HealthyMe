import 'package:healthy_me/src/model/api/profession_model.dart';
import 'package:healthy_me/src/model/api/doctors_list_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  Repository _repository = Repository();

  final _infoDocFetcher = PublishSubject<DoctorsListModel>();
  final _categoriesFetcher = PublishSubject<ProfessionModel>();

  Stream<DoctorsListModel> get getDocs => _infoDocFetcher.stream;

  Stream<ProfessionModel> get getCategories => _categoriesFetcher.stream;

  fetchDocList(
    String text,
    int regionId,
    int cityId,
    int categoryId,
  ) async {
    var response = await _repository.fetchDocList(
      text,
      regionId,
      cityId,
      categoryId,
    );
    if (response.isSuccess) {
      DoctorsListModel result = DoctorsListModel.fromJson(response.result);
      _infoDocFetcher.sink.add(result);
    }
  }

  fetchCategories() async {
    var response = await _repository.fetchRegion();
    if (response.isSuccess) {
      ProfessionModel result = ProfessionModel.fromJson(response.result);
      _categoriesFetcher.sink.add(result);
    }
  }

  dispose() {
    _infoDocFetcher.close();
    _categoriesFetcher.close();
  }
}

final blocHome = HomeBloc();
