import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../../utils/api_requester.dart';
import '../../utils/app_constants.dart';

abstract class ChangepasswordDataRepository {
  Future<HttpResponseModel> changepassword(Map request, String token);
}

class ChangepasswordRepository implements ChangepasswordDataRepository {
  final ApiRequester _apiRequester = new ApiRequester();
  Future<HttpResponseModel> changepassword(
      Map requestBody, String token) async {
    final response = await _apiRequester.apiRequest(
        HttpMethod.Post, ApiUrl.changepasswordUrl,
        requestBody: requestBody, token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }
}
