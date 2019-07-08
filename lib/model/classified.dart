class Classified {
  String subject;
  String postedBy;
  String postedDate;
  String location;
  Classified({this.location, this.postedBy, this.postedDate, this.subject});
  Classified.fromJson(dynamic obj) {
    this.subject = obj['Subject'];
     this.postedBy = obj['UserName'];
      this.postedDate = obj['PostDateFormatted'];
       this.location = obj['LocName'];
  }
}
