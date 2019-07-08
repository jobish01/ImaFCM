class Notification {
  int idUser;
  int level;
  String levelTable;
  int membershipType;
  int branchCode;
  int typeConverstionCount;
  int branchtransferCount;
  int pendingMembershipReqCount;
  int totalCount;
  int schemereqcount;
  int concern;
  int schemeconcerncount;
  int schemepaymentcount;
  int membershippaymentcount;
  int schemePaymentPending;
  int adminpaymentCount;
  int deathCount;
  int rejectCount;
  int doctorListing;

  Notification.fromJson(dynamic obj) {
    idUser = obj['iD_User'];
    level = obj['level'];
    levelTable = obj['levelTable'];
    membershipType = obj['membershipType'];
    branchCode = obj['branchCode'];
    typeConverstionCount = obj['typeConverstionCount'];
    branchtransferCount = obj['branchtransferCount'];
    pendingMembershipReqCount = obj['pendingMembershipReqCount'];
    totalCount = obj['totalCount'];
    schemereqcount = obj['schemereqcount'];
    concern = obj['concern'];
    schemeconcerncount = obj['schemeconcerncount'];
    schemepaymentcount = obj['schemepaymentcount'];
    membershippaymentcount = obj['membershippaymentcount'];
    schemePaymentPending = obj['schemePaymentPending'];
    adminpaymentCount = obj['adminpaymentCount'];
    deathCount = obj['deathCount'];
    rejectCount = obj['rejectCount'];
    doctorListing = obj['doctorListing'];
  }
}
