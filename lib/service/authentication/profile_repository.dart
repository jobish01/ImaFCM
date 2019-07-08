import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../../utils/api_requester.dart';
import '../../model/profile.dart';
import '../../utils/app_constants.dart';

abstract class ProfileDataRepository {
  Future<Profile> login(Map request);
  Future<HttpResponseModel> getMemberProfile(String userId,String token);
}

class ProfileRepository implements ProfileDataRepository {
  final ApiRequester _apiRequester = new ApiRequester();
  @override
  Future<Profile> login(Map request) async {   
    final response = await _apiRequester.sendRequest(RequestType.Post,ApiUrl.profileUrl,request);
    return new Future.value(new Profile.fromJson(response));
  }

  @override
  Future<HttpResponseModel> getMemberProfile(
      String userId,String token) async {
    final response = await _apiRequester.apiRequest(
        HttpMethod.Get, ApiUrl.profileUrl + userId,token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
  }
}