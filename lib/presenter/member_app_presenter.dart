import 'package:ima_connect_app/model/httpResponseModel.dart';

import '../service/memberapprovals/member_app_repository.dart';

abstract class MemberApprovalContract {
  void onMemberApprovalListSuccess(HttpResponseModel httpRep);
  void onMemberApprovalListError(String error);
  void onMemberApprovalDetailsSuccess(HttpResponseModel httpRep);
  void onMemberApprovalDetailsError(String error);
}

class MemberApprovalPresenter {
  MemberApprovalContract _view;
  MemberApprovalService _clsRepository = new MemberApprovalRepository();
  MemberApprovalPresenter(this._view);

  // doMemberApprovalList(Map request) {
  //   _clsRepository
  //       .loadMemberApprovals(request)
  //       .then((memApp) => _view.onMemberApprovalListSuccess(memApp))
  //       .catchError((onError) => _view.onMemberApprovalListError(onError.toString()));
  // }

  doMemberApprovalList(Map request, String token) {
    _clsRepository
        .loadMemberApprovals(request, token)
        .then((memApp) => _view.onMemberApprovalListSuccess(memApp))
        .catchError(
            (onError) => _view.onMemberApprovalListError(onError.toString()));
  }

  doMemberApprovalDetails(String userId, String token) {
    _clsRepository
        .getMemberApprovalDetails(userId, token)
        .then((memApp) => _view.onMemberApprovalDetailsSuccess(memApp))
        .catchError((onError) =>
            _view.onMemberApprovalDetailsError(onError.toString()));
  }
}
