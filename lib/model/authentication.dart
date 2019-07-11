class Authentication {
  int idUser;
  String uEmail;
  String uPassword;
  String profileImage;
  String token;
  String role;
  String levelTable;
  int level;
  int membershipType;
  int branchCode;
  String uName;
  String deviceID;

  Authentication(
      {this.idUser,
      this.uEmail,
      this.uPassword,
      this.profileImage,
      this.token,
      this.role,
      this.levelTable,
      this.level,
      this.branchCode,
      this.membershipType,
      this.uName,
      this.deviceID});

  Authentication.fromJson(dynamic obj) {
    this.idUser = obj['iD_User'];
    this.profileImage = obj['profileImage'];
    this.uEmail = obj['uEmail'];
    this.uPassword = obj['uPassword'];
    this.token = obj['token'];
    this.role = obj['role'];
    this.levelTable = obj['levelTable'];
    this.level = obj['level'];
    this.branchCode = obj['branchCode'];
    this.membershipType = obj['membershipType'];
    this.profileImage = obj['profileImage'];
    this.uName = obj['uName'];
    this.deviceID=obj['deviceID'];
  }
}
