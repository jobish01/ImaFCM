class MemberApproval {
  int userId;
  String membername;
  //String tmpData;
  String profilepic;
  String memno;
  String membershiptypename;
 MemberApproval({this.membername,this.userId,this.profilepic,this.memno,this.membershiptypename});
 MemberApproval.fromJson(dynamic obj) 
 {
   this.userId=obj['user_id'];
   this.membername=obj['membername'];
   //this.tmpData=obj['tmpData'];
   this.profilepic=obj['profilepic'];
   //this.memno=
   //this.membershiptypename
 }
}