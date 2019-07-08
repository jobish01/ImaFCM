import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../service/authentication/changepassword_repository.dart';

abstract class Changepasswordcontract {
  void onChangePasswordSuccess(HttpResponseModel auth);
  void onChangePasswordError(String error);
}

class ChangepasswordPresenter {
  Changepasswordcontract _view;
  ChangepasswordDataRepository _changePasswordRepository =
      new ChangepasswordRepository();
  ChangepasswordPresenter(this._view);

  doChangePassword(Map request,String token) {
    _changePasswordRepository
        .changepassword(request,token)
        .then((httpReponse) => _view.onChangePasswordSuccess(httpReponse))
        .catchError(
            (onError) => _view.onChangePasswordError(onError.toString()));
  }
}
