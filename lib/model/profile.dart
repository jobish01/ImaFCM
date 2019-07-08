class Profile {
  String membername;
  String mobileNumber;
  String sex;
  String mail;
  String designationName;
  String membershiptypename;
  String faorhusname;
  bool maritialstatus;
  String regnumber;
  int userFee;
  int totalAmount;
  List<Address> address = [];
  Profile(
      {this.membername,
      this.mobileNumber,
      this.mail,
      this.designationName,
      this.membershiptypename,
      this.faorhusname,
      this.address});

  Profile.fromJson(dynamic obj) {
    this.membername = obj['membername'];
    this.sex=obj['sex'];
    this.mobileNumber = obj['mobnumber'];
    this.mail = obj['mail'];
    this.designationName = obj['designation_name'];
    this.membershiptypename = obj['membershiptypename'];
    this.faorhusname=obj['faorhusname'];
    this.maritialstatus=obj['maritialstatus'];
    this.userFee=obj['UserFee'];
    this.totalAmount=obj['TotalAmount'];
    this.regnumber=obj['regnumber'];
    List<Address> temp = [];
    for (int i = 0; i < obj['address'].length; i++) {
      Address result = Address.fromJson(obj['address'][i]);
      temp.add(result);
    }
    this.address = temp;
  }
}

class Address {
  String post;
  String streetName;
  String houseName;
  Address({this.post,this.streetName,this.houseName});  
  Address.fromJson(dynamic obj) {
    this.post = obj['post'];
    this.houseName = obj['HouseName'];
    this.streetName=obj['StreetName'];
  }
    
}

// class Profile {
//   String membername;
//   String mobileNumber;
//   String mail;
//   String designationName;
//   String membershiptypename;
//   int idUser;
//   int level;
//   String levelTable;
//   String memberStatus;

//   Profile.fromJson(dynamic obj) {
//     this.membername = obj['membername'];
//     this.mail = obj['mail'];
//     this.mobileNumber = obj['mobnumber'];
//     this.designationName = obj['designation_name'];
//     this.membershiptypename = obj['membershiptypename'];
//     this.idUser = obj['iD_User'];
//     this.level = obj['level'];
//     this.levelTable = obj['levelTable'];
//     this.memberStatus = obj['memberStatus'];
//   }
// }
