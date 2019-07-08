import '../../utils/api_requester.dart';
import '../../model/classified.dart';
import '../../utils/app_constants.dart';

abstract class ClassifiedService {
  Future<List<Classified>> loadClassifieds();
}

class ClassifiedRepository implements ClassifiedService {
  final ApiRequester _apiRequester = new ApiRequester();
  @override
  Future<List<Classified>> loadClassifieds() async {
    var requestBody = {
      "ID_ClassifiedPost": 0,
      "ID_Classifieds": 0,
      "FK_ClassifiedCategory": 0,
      "FK_SubClassifiedCategory": 0,
      "FK_User": 0,
      "Subject": "",
      "FK_Classifieds": 0,
      "FK_Location": 0,
      "From_User": 0,
      "To_User": 0,
      "PostDate": "2019-03-22T05:48:53.573Z",
      "EmailID": "",
      "MobileNo": "",
      "Message": "",
      "CatName": "",
      "SubCatName": "",
      "LocName": "",
      "UserName": "",
      "MemberClassifiedPost": []
    };
    final response =
        await _apiRequester.testRequest("POST",ApiUrl.classifiedUrl,requestBody:requestBody);
       final List resItems = response;
    return resItems.map((resRaw) => Classified.fromJson(resRaw)).toList();
   
  }
}
