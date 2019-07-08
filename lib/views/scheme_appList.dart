import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../model/scheme.dart';
import '../presenter/scheme_app_presenter.dart';
import '.././utils/app_constants.dart';

class SchemeApprovalList extends StatefulWidget {
  final int uid;
  final Widget child;
  final String token;
  final int level;
  final String levelTable;
  final String schmeApprovalstatus;
  SchemeApprovalList(
      {Key key,
      this.child,
      this.uid,
      this.token,
      this.level,
      this.levelTable,
      this.schmeApprovalstatus})
      : super(key: key);
  @override
  _SchemeApprovalListState createState() => _SchemeApprovalListState();
}

class _SchemeApprovalListState extends State<SchemeApprovalList>
    implements SchemeApprovalContract {
  SchemeApprovalPresenter _presenter;
  _SchemeApprovalListState() {
    _presenter = new SchemeApprovalPresenter(this);
  }

  List<SchemeApproval> _schemeapplist = [];
  @override
  void initState() {
    super.initState();
    onLoadSchemesApprovals();
  }

  var _isLoading = RequestStatus.InProgress;

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
          flexibleSpace: FlexibleSpaceBar(
            //centerTitle: true,
            title: Text("Scheme Approvals",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: "Raleway")),
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: _isLoading == RequestStatus.Found
              ? ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(right: 20.0, left: 20.0),
                        child: new Divider(),
                      ),
                  itemCount: _schemeapplist.length,
                  itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(
                            right: 20.0, left: 10.0, bottom: 15.0),
                        child: new ListTile(
                          title: Text(
                            _schemeapplist[index].membershipTypeName,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                    child: RichText(
                                  text: TextSpan(
                                    text:
                                        _schemeapplist[index].memberName + '\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: 'Enroll No:' +
                                              _schemeapplist[index]
                                                  .enrollno
                                                  .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontSize: 10,
                                          )),
                                    ],
                                  ),
                                )),
                              )
                            ],
                          ),
                          leading: Container(
                              padding: EdgeInsets.only(right: 5.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white24))),
                              child: CircleAvatar(
                                child: Text("S"),
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              )),
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                          onTap: () => {
                                //Navigator.push(context,MaterialPageRoute(builder: (context) => SchemeApprovals()))
                              },
                        ),
                      ),
                )
              : new Center(
                  child: _isLoading == RequestStatus.InProgress
                      ? new CircularProgressIndicator()
                      : Text(
                          "No Pending Scheme Approvals",
                          style: TextStyle(color: Colors.indigo),
                        ),
                ),
        ));
  }

  onLoadSchemesApprovals() {
    _presenter.doSchemeApprovalList(
        0, widget.schmeApprovalstatus, widget.uid, widget.token);
  }

  @override
  void onSchemeApprovalListError(String error) {
    print('$error');
  }

  @override
  void onSchemeApprovalListSuccess(HttpResponseModel httpresponse) {
    if (httpresponse.responseCode == ResponseCode.SUCCESS) {
      List memberAppList = httpresponse.response;
      List<SchemeApproval> _schemeApprovalList = [];
      _schemeApprovalList = memberAppList
          .map((resRaw) => SchemeApproval.fromJson(resRaw))
          .toList();
      setState(() {
        _schemeapplist = _schemeApprovalList;
        if (_schemeapplist.length > 0) {
          _isLoading = RequestStatus.Found;
        } else {
          _isLoading = RequestStatus.NullData;
        }
      });
    }
  }
}
