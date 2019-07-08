class Constants {
  static String methodPost = "POST";
  static String methodGet = "GET";
  static String baseUrl = "http://52.77.230.142:93/api/";
  static String oldUrl = "http://52.77.74.254:92/";
}

class ApiUrl {
  static String loginUrl = "Authentication/ValidateLogin";
  static String menuListUrl = "Menu/GetMenuList";
  static String notoficationCountUrl = "Dashboard/GetNotificationCount";
  static String profileUrl = "Membership/GetMemberProfile/";
  static String classifiedUrl = "Classifieds/GetMemberClassifiedsDeatils";
  static String memberApprovalListUrl = "Membership/GetMembershipApprovalData";
  static String schemeApprovalListUrl = "Scheme/GetSchemeAprrovalData";
  static String forgotpasswordUrl = "Dataservice/forgotpassword";
  static String concernsListUrl ="Concern/GetConcernDataList";
  static String changepasswordUrl ="Membership/ChangePassword";
}

enum RequestType {
  Post,
  Get,
}

class HttpMethod {
  static const Get = "GET";
  static const Post = "POST";
  static const Put = "PUT";
  static const Delete = "DELETE";
}

class ResponseCode {
  static const SUCCESS = "101";
  static const WARNING = "301";
}

enum RequestStatus {
  InProgress,
  NullData,
  Found,
}

class PopUpMenuItem {
  static const String SignOut = "SignOut";
  static const List<String> choices = <String>[
    SignOut,
  ];
}
