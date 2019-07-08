import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../../utils/api_requester.dart';
import '../../utils/app_constants.dart';

abstract class AuthenticationRepository {
  Future<HttpResponseModel> validateLogin(String username, String password);
  Future<int> forgotPassword(String emailID);
}

class LoginRepository implements AuthenticationRepository {
  final ApiRequester _apiRequester = new ApiRequester();
  

  @override
  Future<HttpResponseModel> validateLogin(
      String username, String password) async {
    var requestBody = {"uEmail": username, "uPwd": password};
    final response = await _apiRequester.apiRequest(
        HttpMethod.Post, ApiUrl.loginUrl,requestBody: requestBody);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }

  @override
  Future<int> forgotPassword(String emailID) async {
    var requestBody = {
      "UEmail": emailID,
    };
    final response = await _apiRequester.sendRequest(
        RequestType.Post, ApiUrl.forgotpasswordUrl,requestBody);
    return response;
  }


}
