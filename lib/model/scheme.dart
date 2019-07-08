class SchemeApproval {
  int enrollno;
  String memberName;
  String membershipTypeName;
  String profilepic;

  SchemeApproval(this.enrollno, this.memberName, this.membershipTypeName,this.profilepic);
  SchemeApproval.fromJson(dynamic obj) {
    enrollno = obj['enrollno'];
    memberName = obj['memberName'];
    membershipTypeName = obj['membershipTypeNmae'];
    profilepic=obj['porfilepictureurl'];
  }
}
