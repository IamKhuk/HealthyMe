import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:healthy_me/src/model/api/region_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc{
  Repository _repository = Repository();

  final _infoFetcher = PublishSubject<ProfileData>();
  final _infoCacheFetcher = PublishSubject<ProfileData>();
  final _regionsFetcher = PublishSubject<RegionModel>();
  final _cityFetcher = PublishSubject<RegionModel>();

  Stream<ProfileData> get getInfo => _infoFetcher.stream;

  Stream<ProfileData> get getInfoCache => _infoCacheFetcher.stream;

  Stream<RegionModel> get getRegions => _regionsFetcher.stream;

  Stream<RegionModel> get getCities => _cityFetcher.stream;

  fetchMe() async {
    var response = await _repository.fetchMe();
    if (response.isSuccess) {
      ProfileModel result = ProfileModel.fromJson(response.result);
      if (result.status == 1) {
        _repository.cacheSetMe(result.user);
        _infoFetcher.sink.add(result.user);
      } else {
        ///error
      }
    } else if (response.status == -1) {
      ///network
    } else {
      ///server error
    }
  }

  fetchUpdateInfo(ProfileModel data) async {
    _repository.cacheSetMe(data.user);
    _infoFetcher.sink.add(data.user);
  }

  fetchMeCache() async {
    ProfileData response = await _repository.cacheGetMe();
    _infoCacheFetcher.sink.add(response);
  }

  fetchMeRegion() async {
    var response = await _repository.fetchRegion();
    if (response.isSuccess) {
      RegionModel result = RegionModel.fromJson(response.result);
      _regionsFetcher.sink.add(result);
    }
  }

  fetchMeCity(int parentID) async {
    var response = await _repository.fetchCity(parentID);
    if (response.isSuccess) {
      RegionModel result = RegionModel.fromJson(response.result);
      _cityFetcher.sink.add(result);
    }
  }

  dispose() {
    _infoFetcher.close();
    _infoCacheFetcher.close();
    _regionsFetcher.close();
    _cityFetcher.close();
  }
}

final blocProfile = ProfileBloc();
