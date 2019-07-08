import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../../utils/api_requester.dart';
import '../../utils/app_constants.dart';

abstract class SchemeApprovalListService {
  Future<HttpResponseModel> loadSchemeApprovals(
      int schemeType, String status, int uid, String token);
}

class SchemeApprovalListRepository implements SchemeApprovalListService {
  final ApiRequester _apiRequester = new ApiRequester();
  @override
  Future<HttpResponseModel> loadSchemeApprovals(
      int schemeType, String status, int uid, String token) async {
    final response = await _apiRequester.apiRequest(
        HttpMethod.Get,
        ApiUrl.schemeApprovalListUrl +
            "/" +
            schemeType.toString() +
            "/" +
            status +
            "/" +
            uid.toString(),
        token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }
}
