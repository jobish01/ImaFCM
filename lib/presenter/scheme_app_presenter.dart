import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../service/Schemeapprovals/scheme_app_repository.dart';

abstract class SchemeApprovalContract {
  void onSchemeApprovalListSuccess(HttpResponseModel httpresponse);
  void onSchemeApprovalListError(String error);
}

class SchemeApprovalPresenter {
  SchemeApprovalContract _view;
  SchemeApprovalListService _clsRepository = new SchemeApprovalListRepository();
  SchemeApprovalPresenter(this._view);

  doSchemeApprovalList(int schemeType,String status,int uid,String token) {
    _clsRepository
        .loadSchemeApprovals(schemeType,status,uid,token)
        .then((schemeApp) => _view.onSchemeApprovalListSuccess(schemeApp))
        .catchError(
            (onError) => _view.onSchemeApprovalListError(onError.toString()));
  }
}
