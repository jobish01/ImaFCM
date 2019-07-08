import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/views/concernsList.dart';
import '../utils/app_constants.dart';
import '../views/classifieds.dart';
import '../views/member_approvals.dart';
//import '../views/webViewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presenter/dashboard_presenter.dart';
import '../views/login.dart';
import '../font_icons/custom_icons.dart';
import '../model/menu_list.dart';
import '../model/notification.dart' as notification;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/my_profile.dart';
import '../views/scheme_appList.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './change_password.dart';

class DashBoard extends StatefulWidget {
  final Widget child;

  DashBoard({Key key, this.child}) : super(key: key);

  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> implements DashBoardContract {
  DashBoardPresenter _presenter;
  _DashBoardState() {
    _presenter = new DashBoardPresenter(this);
  }

  Menu _menu = new Menu();
  SharedPreferences prefs;
  int schemeCount = 0;
  int memAppCount = 0;
  int concernCount = 0;
  int idUser = 0;
  String uName = " ";
  String username = " ";
  String designation = " ";
  String schmeApprovalstatus = " ";
  String token = "";
  String levelTable = " ";
  String role = " ";
  int level = 0;
  int membershipType = 0;
  int branchCode = 0;
  String profileImage = '';

  @override
  void initState() {
    super.initState();
    readKeys();
    //getUserMenu();
    setState(() {
      _menu.schemeApprovals = false;
      _menu.showMemberShip = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      height: 200.0,
      child: new SizedBox(
          height: 200.0,
          width: 350.0,
          child: new Carousel(
            images: [
              new NetworkImage(
                  'https://images.unsplash.com/photo-1545063328-c8e3faffa16f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
              new NetworkImage(
                  'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
              new NetworkImage(
                  'https://images.unsplash.com/photo-1474823310278-5c40989a3fd5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
              new NetworkImage(
                  'https://images.unsplash.com/photo-1533310266094-8898a03807dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
              new NetworkImage(
                  'https://images.unsplash.com/photo-1551721434-8b94ddff0e6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
            ],
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.indigo,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.white,
            borderRadius: true,
          )),
    );
    return WillPopScope(
      child: new Scaffold(
        body: Stack(children: <Widget>[
          new Container(
            color: Colors.indigo,
            child: new Column(
              children: <Widget>[
                new Container(
                  //height: MediaQuery.of(context).size.height * .13,
                  height: MediaQuery.of(context).size.height * .12,
                ),
                Expanded(
                    child: new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: new ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      approvals(),
                      _classifieds(),
                      _onlineSite(),
                      imageCarousel,
                    ],
                  ),
                ))
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Padding(
          //       padding: const EdgeInsets.only(top: 15),
          //       child: Column(
          //         children: <Widget>[
          //           IconButton(
          //             icon: Icon(Icons.dehaze, color: Colors.white, size: 20),
          //             onPressed: () {
          //               //Navigator.of(context).pop();
          //             },
          //           ),
          //         ],
          //       )),
          // ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 15),
          //     child: PopupMenuButton<String>(
          //       icon: Icon(Custom.cog, color: Colors.white, size: 20),
          //       onSelected: choiceAction,
          //       itemBuilder: (BuildContext context) {
          //         return PopUpMenuItem.choices.map((String choice) {
          //           return new PopupMenuItem<String>(
          //               child: Text(choice), value: choice);
          //         }).toList();
          //       },
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: IconButton(
                  icon: Icon(Custom.cog, color: Colors.white, size: 20),
                  onPressed: () {
                    containerForSheet<String>(
                      context: context,
                      child: CupertinoActionSheet(
                          // title: const Text('Choose frankly 😊'),
                          // message: const Text(
                          //     'Your options are '),
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: const Text(
                                'Sign Out',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                _exitApp(context, "Are you sure to sign out");
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const Text(
                                'Change Password',
                                style: TextStyle(fontSize: 15),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new ChangePassword(
                                                uid: idUser,
                                                token: token,
                                                username: username)));
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal),
                            ),
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context, 'Cancel');
                            },
                          )),
                    );
                  },
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 20),
                //padding: const EdgeInsets.only(top: 50, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    profileImage == ""
                        ? InkWell(
                            child: CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/images/dp.png'),
                                radius: 15),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new ProfilePage(
                                          uid: idUser, token: token)));
                            },
                          )
                        : InkWell(
                            child: CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/images/dp.png'),
                                radius: 15),
                            // child: CircleAvatar(
                            //   child: CachedNetworkImage(
                            //     imageUrl: profileImage,
                            //     errorWidget: (context, url, error) =>
                            //          CircleAvatar(
                            //     backgroundImage:
                            //         ExactAssetImage('assets/images/dp.png'),
                            //     radius: 15),
                            //   ),
                            //   backgroundColor: Colors.indigo,
                            //   foregroundColor: Colors.white,
                            //   radius: 15,
                            // ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new ProfilePage(
                                          uid: idUser, token: token)));
                            },
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: uName != null ? uName + '\n' : " " + '\n',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                              text: designation != null ? designation : " ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 9,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ]),
      ),
      onWillPop: () => _exitApp(context, "Are you sure to exit"),
    );
  }

  Widget widgetScheme() {
    return new ListTile(
        title: Text(
          'Scheme Approvals',
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    child: Text(schemeCount.toString() + '  Pending Approvals',
                        style: TextStyle(color: Colors.grey, fontSize: 10))))
          ],
        ),
        leading: Container(
          padding: EdgeInsets.only(right: 5.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: new SvgPicture.asset(
            "assets/images/schemeapprovals.svg",
            height: 45,
            color: Colors.orange,
          ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new SchemeApprovalList(
                      uid: idUser,
                      token: token,
                      level: level,
                      levelTable: levelTable,
                      schmeApprovalstatus: schmeApprovalstatus)));
        });
  }

  Widget widgetMemberApproval() {
    return new ListTile(
        title: Text(
          'Member Approvals',
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    child: Text(memAppCount.toString() + '  Pending Approvals',
                        style: TextStyle(color: Colors.grey, fontSize: 10))))
          ],
        ),
        leading: Container(
          padding: EdgeInsets.only(right: 5.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: new SvgPicture.asset(
            "assets/images/membershipapprovals.svg",
            color: Colors.orange,
            height: 45,
          ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new MemberApprovals(
                        uid: idUser,
                        level: level,
                        levelTable: levelTable,
                        token: token,
                      )));
        });
  }

  Widget widgetConcern() {
    return new ListTile(
        title: Text(
          'Concerns',
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    child: Text(concernCount.toString() + ' New Concerns',
                        style: TextStyle(color: Colors.grey, fontSize: 10))))
          ],
        ),
        leading: Container(
          padding: EdgeInsets.only(right: 5.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: new SvgPicture.asset(
            "assets/images/concerns.svg",
            height: 45,
            color: Colors.orange,
          ),
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20.0),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new ConsernsList(
                        userId: idUser,
                        branchId: branchCode,
                        token: token,
                      )));
        });
  }

  Widget approvals() {
    return Column(children: <Widget>[
      _menu.schemeApprovals ? widgetScheme() : new Container(),
      _menu.schemeApprovals
          ? Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            )
          : new Container(),
      _menu.showMemberShip ? widgetMemberApproval() : new Container(),
      _menu.showMemberShip
          ? Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            )
          : new Container(),
      widgetConcern(),
      new Divider()
    ]);
  }

  Widget _classifieds() {
    return new Column(
      children: <Widget>[
        new ListTile(
            title: Text("Classifieds"),
            leading: Container(
                padding: EdgeInsets.only(right: 5.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.white24))),
                child: CircleAvatar(
                  child: new SvgPicture.asset(
                    "assets/images/classifieds_active.svg",
                    color: Colors.white,
                    height: 25,
                  ),
                  backgroundColor: Colors.indigo,
                  //foregroundColor: Colors.indigo,
                )),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.grey, size: 20.0),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => new Classifieds()))),
      ],
    );
  }

  Widget _onlineSite() {
    return new Column(children: <Widget>[
      new Divider(
        color: Colors.grey,
      ),
      new ListTile(
          title: Text("imaKerala.com",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7))),
          leading: Container(
              padding: EdgeInsets.only(right: 5.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: CircleAvatar(
                child: Icon(Custom.globe_1),
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
              )),
          onTap: () => _launchURL('http://www.imakerala.com')),
      Container(
        padding: EdgeInsets.only(right: 20.0, left: 20.0),
        child: new Divider(),
      ),
      new ListTile(
          title: Text("imaKerala.live",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.7))),
          leading: Container(
              padding: EdgeInsets.only(right: 5.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: CircleAvatar(
                child: Icon(Custom.globe_1),
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
              )),
          onTap: () => _launchURL('https://www.imalive.in'))
    ]);
  }

  void choiceAction(String choice) {
    switch (choice) {
      case PopUpMenuItem.SignOut:
        _exitApp(context, "Are you sure to sign out");
        //openDialog();
        break;
    }
  }

  Future<bool> _exitApp(BuildContext context, String _text) async {
    return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return new CupertinoAlertDialog(
                title: new Column(
                  children: <Widget>[
                    new Text(_text),
                    // new Icon(Icons.add_to_home_screen,color: Colors.blue,)
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        _signOut();
                      },
                      child: Text("Yes")),
                  new FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text("No"))
                ],
              );
            }) ??
        false;
  }

  _signOut() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => new LoginPage()));
    } catch (e) {
      print(e);
    }
  }

  getUserMenu() {
    _presenter.doMenuList();
  }

  getNotificationCount() {
    var requestBody = {
      "ID_User": idUser,
      "Level": level,
      "LevelTable": levelTable,
      "MembershipType": membershipType,
      "BranchCode": branchCode
    };
    _presenter.doNofificationCount(requestBody, token);
  }

  readKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      schmeApprovalstatus = prefs.getString('schmeApprovalstatus');
      username = prefs.getString('username');
      idUser = prefs.getInt('iduser');
      token = prefs.getString('token');
      uName = prefs.getString('uName');
      designation = prefs.getString('desgn');
      role = prefs.getString('role');
      levelTable = prefs.getString('levelTable');
      level = prefs.getInt('level');
      membershipType = prefs.getInt('membershipType');
      branchCode = prefs.getInt('branchCode');
      profileImage = prefs.getString('profileImage');
    });
    setMenu();
    getNotificationCount();
  }

  @override
  void onMenulistError(String error) {
    debugPrint('get menu error');
  }

  @override
  void onMenulistSuccess(Menu menu) {
    setState(() {
      _menu = menu;
    });
  }

  @override
  void onNotificationCountError(String error) {
    debugPrint('notification count error');
  }

  @override
  void onNotificationCountSuccess(HttpResponseModel httpResp) {
    if (httpResp.responseCode == ResponseCode.SUCCESS) {
      notification.Notification notifi =
          new notification.Notification.fromJson(httpResp.response);
      setState(() {
        memAppCount = notifi.pendingMembershipReqCount;
        schemeCount = notifi.schemereqcount;
        concernCount = notifi.concern;
      });
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // if (value != null) {
      //   Scaffold.of(context).showSnackBar(new SnackBar(
      //     content: new Text('You clicked $value'),
      //     duration: Duration(milliseconds: 800),
      //   ));
      // }
    });
  }

  void setMenu() {
    if (role == "Sec" && levelTable == "branch") {
      setState(() {
        designation = "Branch Secretary";
        schmeApprovalstatus = "Req";
        _menu.schemeApprovals = true;
        _menu.showMemberShip = true;
      });
    }
    if (role == "Sec" && levelTable == "scheme") {
      setState(() {
        designation = "Scheme Secretary";
        schmeApprovalstatus = "BApr";
        _menu.schemeApprovals = true;
        _menu.showMemberShip = false;
      });
    }
    if (role == "Sec" && levelTable == "state") {
      setState(() {
        schmeApprovalstatus = "Req";
        designation = "state Secretary";
        _menu.schemeApprovals = true;
        _menu.showMemberShip = true;
      });
    }
    if (levelTable == "stateadmin" && role == "Admin") {
      setState(() {
        schmeApprovalstatus = "SAdmin";
        designation = "State Admin";
        _menu.schemeApprovals = true;
        _menu.showMemberShip = false;
      });
    }
    if (role == "User") {
      setState(() {
        designation = " ";
      });
    }
    if (role == "clrk") {
      setState(() {
        designation = "Clerk";
      });
    }
    if (role == "Pres" && levelTable == "statepresident") {
      setState(() {
        designation = "State President";
      });
    }
    if (role == "Pres" && levelTable == "branchpresident") {
      setState(() {
        designation = "Branch President";
      });
    }
  }
}
