import 'package:ima_connect_app/model/httpResponseModel.dart';


import '../service/dashboard/dashboard_repository.dart';
import '../model/menu_list.dart';

abstract class DashBoardContract {
  void onMenulistSuccess(Menu menu);
  void onMenulistError(String error);
  void onNotificationCountSuccess(HttpResponseModel httpres);
  void onNotificationCountError(String error);
}

class DashBoardPresenter {
  DashBoardContract _view;
  DashBoardService _dashBoardRepository = new DashBoardRepository();
  DashBoardPresenter(this._view);

  doMenuList() {
    _dashBoardRepository
        .getMenuList()
        .then((menu) => _view.onMenulistSuccess(menu))
        .catchError((onError) => _view.onMenulistError(onError.toString()));
  }

  doNofificationCount(Map notificationReq,String token)
  {
     _dashBoardRepository
        .getNotificationCounts(notificationReq,token)
        .then((notification) => _view.onNotificationCountSuccess(notification))
        .catchError((onError) => _view.onNotificationCountError(onError.toString()));
  }
}
