import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../service/authentication/profile_repository.dart';

abstract class ProfileContract {
  void onProfileDataSuccess(HttpResponseModel httpResp);
  void onProfileDataError(String error);
}

class ProfilePresenter {
  ProfileContract _view;
  ProfileDataRepository _loginRepository = new ProfileRepository();
  ProfilePresenter(this._view);

  doProfileData(String userId,String token) {
    _loginRepository
        .getMemberProfile(userId,token)
        .then((profile) => _view.onProfileDataSuccess(profile))
        .catchError((onError) => _view.onProfileDataError(onError.toString()));
  }
}