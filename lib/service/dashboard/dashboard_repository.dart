import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../../utils/api_requester.dart';
import '../../model/menu_list.dart';
import '../../utils/app_constants.dart';

abstract class DashBoardService {
  Future<Menu> getMenuList();
  Future<HttpResponseModel> getNotificationCounts(Map notificationReq,String token );
}

class DashBoardRepository implements DashBoardService {
  final ApiRequester _apiRequester = new ApiRequester();
  @override
  Future<Menu> getMenuList() async {
    var requestBody = {"Mode":"BRS"};
    final response = await _apiRequester.sendRequest(RequestType.Post,ApiUrl.menuListUrl, requestBody);
    return new Future.value(new Menu.fromJson(response[0]));
  }

  @override
  Future<HttpResponseModel> getNotificationCounts(Map notificationReq,String token) async { 
    final response = await _apiRequester.apiRequest(
        HttpMethod.Post, ApiUrl.notoficationCountUrl,requestBody: notificationReq,token: token);
    return new Future.value(new HttpResponseModel.fromJson(response));
    // final response = await _apiRequester.apiRequest(HttpMethod.Post,ApiUrl.notoficationCountUrl, notificationReq);
    // return new Future.value(new Notification.fromJson(response));
  }
}