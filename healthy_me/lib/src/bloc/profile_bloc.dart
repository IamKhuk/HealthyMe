import 'package:healthy_me/src/model/api/profile_model.dart';
import 'package:healthy_me/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProfileBloc{
  Repository _repository = Repository();

  final _infoFetcher = PublishSubject<ProfileData>();
  final _infoCacheFetcher = PublishSubject<ProfileData>();

  Stream<ProfileData> get getInfo => _infoFetcher.stream;

  Stream<ProfileData> get getInfoCache => _infoCacheFetcher.stream;

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

  dispose() {
    _infoFetcher.close();
    _infoCacheFetcher.close();
  }
}

final blocProfile = ProfileBloc();
