import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../../utils/api_requester.dart';
import '../../utils/app_constants.dart';

abstract class MemberApprovalService {
  Future<HttpResponseModel> loadMemberApprovals(Map request,String token);
  Future<HttpResponseModel> getMemberApprovalDetails(String userId,String token);
}

class MemberApprovalRepository implements MemberApprovalService {
  final ApiRequester _apiRequester = new ApiRequester();
  @override
  Future<HttpResponseModel> loadMemberApprovals(Map requestBody,String token) async {
    final response = await _apiRequester.apiRequest(
        HttpMethod.Post, ApiUrl.memberApprovalListUrl,
        requestBody: requestBody,token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }

  // @override
  // Future<Profile> getMemberApprovalDetails(Map requestBody) async {
  //   final response = await _apiRequester.sendRequest(
  //       RequestType.Post, ApiUrl.profileUrl, requestBody);
  //   return new Future.value(new Profile.fromJson(response));
  // }

  @override
  Future<HttpResponseModel> getMemberApprovalDetails(String userId,String token) async {
     final response = await _apiRequester.apiRequest(
        HttpMethod.Get, ApiUrl.profileUrl + userId,token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }
}
