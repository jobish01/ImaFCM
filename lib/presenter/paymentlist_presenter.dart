import '../model/notification.dart';

abstract class PaymentListContract {

  void onNotificationCountSuccess(Notification notification);
  void onNotificationCountError(String error);
}

class PaymentListPresenter {
  //PaymentListContract _view;
  //DashBoardService _dashBoardRepository = new DashBoardRepository();
 // PaymentListPresenter(this._view);

  // doNofificationCount(Map notificationReq)
  // {
  //    _dashBoardRepository
  //       .getNotificationCounts(notificationReq)
  //       .then((notification) => _view.onNotificationCountSuccess(notification))
  //       .catchError((onError) => _view.onNotificationCountError(onError.toString()));
  // }
}
