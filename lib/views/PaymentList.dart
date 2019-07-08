import 'package:flutter/material.dart';
import 'package:ima_connect_app/views/home.dart';
import '../presenter/paymentlist_presenter.dart';
//import 'package:ima_connect_app/utils/app_constants.dart';
import '../views/payments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/notification.dart' as notification;

class PaymentList extends StatefulWidget {
  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList>
    implements PaymentListContract {
  @override
  void initState() {
    super.initState();
    
  }

  //PaymentListPresenter _presenter;
  _PaymentListState() {
   // _presenter = new PaymentListPresenter(this);
  }

  SharedPreferences prefs;
  int schemeCount = 0;
  int memAppCount = 0;
  int idUser = 0;
  String uName = " ";
  String desgn = " ";

  //var _isLoading = RequestStatus.InProgress;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
                padding: EdgeInsets.only(right: 5.0),
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: 20.0),
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new Home()));
                    })),
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Scheme Payments",
                    style:
                        TextStyle(color: Colors.indigo, fontFamily: "Raleway"),
                  ),
                ),
                Tab(
                  child: Text(
                    "Membership Payments",
                    style:
                        TextStyle(color: Colors.indigo, fontFamily: "Raleway"),
                  ),
                ),
              ],
            ),
            title: Text(
              'Payments',
              style: TextStyle(color: Colors.black, fontFamily: "Raleway"),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .1,
                      ),
                      child: schemePayment(),
                    ),
                  ],
                ),
                membershipPayment()
              ],
            ),
          ),
        ),
      ),
      onWillPop: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Home()));
      },
    );
  }

  Widget schemePayment() {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: schemeCount > 1
          ? ListView.separated(
              separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                  ),
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                        right: 20.0, left: 10.0, top: 10.0, bottom: 15.0),
                    child: new ListTile(
                      title: Text(
                        '14 Sep 2018 ',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                                child: FittedBox(
                              child: RichText(
                                text: TextSpan(
                                  text: 'SSS -Enroll No(62)-Adminssion Fee \n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '8500/-',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.orange,
                                            fontSize: 20)),
                                  ],
                                ),
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
                                    width: 1.5, color: Colors.white24))),
                        child: new CircleAvatar(
                          child: Text('₹'),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 20.0,
                      ),
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment()))
                          },
                    ),
                  ),
            )
          : new Center(
              child: Text('No Data'),
            ),
    );
  }

  Widget membershipPayment() {
    return Container();
  }

  // getNotificationCount() {
  //   var requestBody = {
  //     "ID_User": idUser,
  //     "Level": 0,
  //     "LevelTable": "",
  //     "MembershipType": 8,
  //     "BranchCode": 49
  //   };
  
  // }

  readKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt('iduser');
    uName = prefs.getString('name');
    desgn = prefs.getString('desgn');
  }

  @override
  void onNotificationCountError(String error) {
    debugPrint('notification count error');
  }

  @override
  void onNotificationCountSuccess(notification.Notification notification) {
    setState(() {
      schemeCount = notification.schemepaymentcount;
      memAppCount = notification.membershippaymentcount;
    });
  }
}
