import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../service/authentication/auth_repository.dart';

abstract class LoginPageContract {
  void onLoginSuccess(HttpResponseModel auth);
  //void onLoginSuccess(Authentication auth);
  void onLoginError(String error);
  void onForgotPasswordSuccess(int responCode);
  void onForgotPasswordError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  AuthenticationRepository _loginRepository = new LoginRepository();
  LoginPagePresenter(this._view);

  // doLogin(String username, String password) {
  //   _loginRepository
  //       .login(username, password)
  //       .then((user) => _view.onLoginSuccess(user))
  //       .catchError((onError) => _view.onLoginError(onError.toString()));
  // }

   doLogin(String username, String password) {
    _loginRepository
        .validateLogin(username, password)
        .then((httpReponse) => _view.onLoginSuccess(httpReponse))
        .catchError((onError) => _view.onLoginError(onError.toString()));
  }


   doForgotPassword(String emailID) {
    _loginRepository
        .forgotPassword(emailID)
        .then((user) => _view.onForgotPasswordSuccess(user))
        .catchError((onError) => _view.onForgotPasswordError(onError.toString()));
  }
}
