import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/model/profile.dart';
import 'package:ima_connect_app/utils/app_constants.dart';
import 'package:ima_connect_app/views/member_approvalDetails.dart';
import '../model/memberApproval.dart';
import '../presenter/member_app_presenter.dart';

class MemberApprovals extends StatefulWidget {
  final Widget child;
  final int uid;
  final int level;
  final String levelTable;
  final String token;
  
  MemberApprovals({Key key, this.child, this.uid, this.level, this.levelTable,this.token})
      : super(key: key);

  _MemberApprovalsState createState() => _MemberApprovalsState();
}

class _MemberApprovalsState extends State<MemberApprovals>
    implements MemberApprovalContract {
  MemberApprovalPresenter _presenter;
  _MemberApprovalsState() {
    _presenter = new MemberApprovalPresenter(this);
  }

  List<MemberApproval> _approvalList = [];
  var _isLoading = RequestStatus.InProgress;

  @override
  void initState() {
    super.initState();
    onLoadMemberApprovals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.black, size: 25.0),
                onPressed: () {}),
            IconButton(
                icon: new SvgPicture.asset(
                  "assets/images/filter.svg",
                  color: Colors.black,
                  height: 25,
                ),
                onPressed: () {})
          ],
          flexibleSpace: FlexibleSpaceBar(
            //centerTitle: true,
            title: Text("Member Approvals",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: "Raleway")),
          ),
        ),
        body: Container(
            color: Colors.white,
            child: new SafeArea(
                child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: _viewMemberApprovals()))));
  }

  Widget _viewMemberApprovals() {
    return _isLoading == RequestStatus.Found
        ? ListView.separated(
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 10.0, left: 10.0),
                  child: new Divider(),
                ),
            itemCount: _approvalList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  new ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                         leading: CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/images/dp.png'),
                                radius: 15),
                    // leading: _approvalList[index].profilepic== "" ? CircleAvatar(
                    //             backgroundImage:
                    //                 ExactAssetImage('assets/images/dp.png'),
                    //             radius: 15) : Image.network(_approvalList[index].profilepic),
                    // Container(
                    //     padding: EdgeInsets.only(right: 5.0),
                    //     decoration: new BoxDecoration(
                    //         border: new Border(
                    //             right: new BorderSide(
                    //                 width: 1.0, color: Colors.white24))),
                    //     child: CircleAvatar(
                    //       child: Text("S"),
                    //       backgroundColor: Colors.orange,
                    //       foregroundColor: Colors.white,
                    //     )),
                    title: Text("Annual Single",
                        style: TextStyle(color: Colors.black54, fontSize: 13)),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(_approvalList[index].membername,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Raleway",
                                  fontSize: 14,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text("Mem no : ",
                                      //"Mem no : " +//_approvalList[index].tmpData,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 13,
                                      )),
                                )),
                          ],
                        )
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black54, size: 20.0),
                    onTap: () {
                      onloadMemberDetails(_approvalList[index].userId);
                    },
                  )
                ],
              );
            })
         : new Center(
                  child: _isLoading == RequestStatus.InProgress
                      ? new CircularProgressIndicator()
                      : Text(
                          "No Member Approvals",
                          style: TextStyle(color: Colors.indigo),
                        ),
                );
  }

  onLoadMemberApprovals() {
    var requestBody = {
      "user_id": widget.uid,
      "level": widget.level,
      "levelTable": widget.levelTable,
      "memberStatus": "Req"
    };

//var requestBody ={"user_id":3,"level":49,"levelTable":"branch","memberStatus":"Req"};
    _presenter.doMemberApprovalList(requestBody,widget.token);
  }

  onloadMemberDetails(int memId) {
   // var requestBody = {"user_id": widget.uid};
    _presenter.doMemberApprovalDetails(widget.uid.toString(),widget.token);
  }

  @override
  void onMemberApprovalListError(String error) {
   setState(() {
 _isLoading =RequestStatus.Found;
   });
  
  }

  @override
  void onMemberApprovalListSuccess(HttpResponseModel httpresponse) {
    if (httpresponse.responseCode == ResponseCode.SUCCESS) {
      List memberAppList = httpresponse.response;
       List<MemberApproval> _memberAppList=[];
      _memberAppList=memberAppList.map((resRaw) => MemberApproval.fromJson(resRaw)).toList();
      setState(() {
        if(memberAppList.length>0)
        {
          _approvalList = _memberAppList;
          _isLoading =RequestStatus.Found;
        }
        else
        {
          _isLoading = RequestStatus.NullData;
        }  
    });
    }
  }

  @override
  void onMemberApprovalDetailsError(String error) {
    _showSnackBar(error);
  }
  void _showSnackBar(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.lightBlue,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  void onMemberApprovalDetailsSuccess(HttpResponseModel httpResp) {
 if (httpResp.responseCode == ResponseCode.SUCCESS) {
      Profile profile = new Profile.fromJson(httpResp.response);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemberApprovalDetails(
                  profile: profile,
                )));
 }
  }
}
