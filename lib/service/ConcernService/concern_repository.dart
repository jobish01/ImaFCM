import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../../utils/api_requester.dart';
import '../../utils/app_constants.dart';

abstract class ConcernService {
  Future<HttpResponseModel> loadConcernList(
      int userid, String branchId, int checkValue, String token);
}

class ConcernServiceRepository implements ConcernService {
  final ApiRequester _apiRequester = new ApiRequester();
  @override
  Future<HttpResponseModel> loadConcernList(
      int userid, String branchId, int checkValue, String token) async {
    final response = await _apiRequester.apiRequest(
        HttpMethod.Get,
        ApiUrl.concernsListUrl +
            "/" +
            userid.toString() +
            "/" +
            branchId +
            "/" +
            checkValue.toString(),
        token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }
}
