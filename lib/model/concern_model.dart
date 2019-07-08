class Concern {
  String username;
  String subject;
  String message;
  String strdate;
  int msgUserId;
  String profilepic;
  Concern(this.username,this.message,this.subject,this.strdate,this.msgUserId);
   Concern.fromJson(dynamic obj) {
    this.username = obj['username'];
    this.message = obj['message'];
     this.subject = obj['subject'];
    this.strdate = obj['strdate'];
     this.msgUserId = obj['msgUserId'];
     this.profilepic=obj['profilepic'];
  }
}