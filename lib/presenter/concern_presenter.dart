import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/service/ConcernService/concern_repository.dart';



abstract class ConcernContract {
  void onConcernsListSuccess(HttpResponseModel httpRep);
  void onConcernsListError(String error);
}

class ConcernPresenter {
  ConcernContract _view;
  ConcernService _clsRepository = new ConcernServiceRepository();
  ConcernPresenter(this._view);

  doConcernList(int userid,String branchId,int checkValue,String token) {
    _clsRepository
        .loadConcernList(userid,branchId,checkValue,token)
        .then((memApp) => _view.onConcernsListSuccess(memApp))
        .catchError((onError) => _view.onConcernsListError(onError.toString()));
  }
}