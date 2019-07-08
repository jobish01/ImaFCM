import '../../model/concern_model.dart';
import 'package:rxdart/rxdart.dart';
abstract class BlocBase {
  void dispose();
}
class ConcernBloc extends BlocBase{
  final ConcernRepository _repository = ConcernService();
  Stream<List<Concern>> _results = Stream.empty();
  Stream<String> _log = Stream.empty();

  BehaviorSubject<dynamic> _query = BehaviorSubject<dynamic>();

  Stream<String> get log => _log;
  Stream<List<Concern>> get allConcerns => _results;
  Sink<dynamic> get query => _query;

  ConcernBloc() {
    _results = _query.asyncMap((app)=>_repository.loadConcerns(app)).asBroadcastStream();    
  }

  void dispose() {
    _query.close();
  }
}

abstract class ConcernRepository {
  
  Future<List<Concern>> loadConcerns(Map dynamic);
}

class ConcernService implements ConcernRepository {

  @override
  Future<List<Concern>> loadConcerns(Map dynamic) async {
    
   List<Concern> _cList=[];
  //  _cList.add(new Concern(1, "hai", 1, "subject 1", DateTime.now()));
  //  _cList.add(new Concern(1, "hello", 2, "subject 2", DateTime.now()));
  //  _cList.add(new Concern(1, "hai", 1, "subject 1", DateTime.now()));
  //  _cList.add(new Concern(1, "hello", 2, "subject 2", DateTime.now()));
  //  _cList.add(new Concern(1, "hai", 1, "subject 1", DateTime.now()));
  //  _cList.add(new Concern(1, "hello", 2, "subject 2", DateTime.now()));
  //  _cList.add(new Concern(1, "hai", 1, "subject 1", DateTime.now()));
  //  _cList.add(new Concern(1, "hello", 2, "subject 2", DateTime.now()));
   return _cList;
  }

}