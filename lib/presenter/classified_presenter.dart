import '../model/classified.dart';
import '../service/classifieds/classifieds_repository.dart';

abstract class ClassifiedsContract {
  void onClassifiedslistSuccess(List<Classified> cls);
  void onClassifiedslistError(String error);
}

class ClassifiedsPresenter {
  ClassifiedsContract _view;
  ClassifiedService _clsRepository = new ClassifiedRepository();
  ClassifiedsPresenter(this._view);

  doClassifiedsList() {
    _clsRepository
        .loadClassifieds()
        .then((cls) => _view.onClassifiedslistSuccess(cls))
        .catchError((onError) => _view.onClassifiedslistError(onError.toString()));
  }

}