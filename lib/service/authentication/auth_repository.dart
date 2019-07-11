import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../../utils/api_requester.dart';
import '../../utils/app_constants.dart';

abstract class AuthenticationRepository {
  Future<HttpResponseModel> validateLogin(String username, String password);
  Future<int> forgotPassword(String emailID);
  Future<HttpResponseModel> insertDeviceToken(int useId,String token,String authToken);
  Future<HttpResponseModel> updateDeviceToken(int useId,String token,String authToken);
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
   // DeviceToken stored to DB for FCM Push Notification
  @override
  Future<HttpResponseModel> insertDeviceToken(int useId,String token,String authToken) async {
    var requestBody = {"uid": useId, "deviceToken": token};
    final response = await _apiRequester.apiRequest(
        HttpMethod.Post, ApiUrl.deviceTokenInsertUrl,requestBody: requestBody,token: authToken);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }

//Update DeviceToken stored to DB if user devicetoken change
@override
  Future<HttpResponseModel> updateDeviceToken(int useId,String token,String authToken) async {
    var requestBody = {"uid": useId, "deviceToken": token};
    final response = await _apiRequester.apiRequest(
        HttpMethod.Post, ApiUrl.deviceTokenUpdateUrl,requestBody: requestBody,token: authToken);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }


}
