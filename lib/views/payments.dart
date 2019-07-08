import 'package:flutter/material.dart';
import 'package:ima_connect_app/views/home.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: new Stack(
          overflow: Overflow.visible,
          alignment: new FractionalOffset(.5, 1.0),
          children: [
            new Container(
              width: double.infinity,
              child: FlatButton(
                padding: EdgeInsets.all(16),
                color: Colors.indigo,
                child: Text("PAYNOW",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {},
              ),
            ),
          ],
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.orange,
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 50.0)),
              ),
              child: AppBar(
                title: Text('Payments',style: TextStyle(fontWeight: FontWeight.bold),),
                backgroundColor: Colors.indigo,
                
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 20.0),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new Home()));
                    }),
                iconTheme: new IconThemeData(color: Colors.white),
                flexibleSpace: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0, bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Text('₹ 8500',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Roboto",
                                      fontSize: 30))),
                          Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Text('Renewal Fee | SSS-Enroll No(62)',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                      fontSize: 15))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                title: Text(
                  'Due Date',
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
                ),
                trailing: Text(
                  '07 Sep 2018',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,fontFamily: "Roboto"),
                ),
                leading: Container(
                  padding: EdgeInsets.only(right: 5.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 3.5, color: Colors.white24))),
                  child: new CircleAvatar(
                    child: Icon(Icons.date_range),
                    backgroundColor: Color(0xFFEFEBE9),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            ),
            new ListTile(
              title: Text(
                'Admission Amount',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
              ),
              trailing: Text(
                '₹ 1000',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,fontFamily: "Roboto"),
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 5.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 3.5, color: Colors.white24))),
                child: new CircleAvatar(
                  child: Text(
                    '₹',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  backgroundColor: Color(0xFFEFEBE9),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            ),
            new ListTile(
              title: Text(
                'Annual Subscription',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
              ),
              trailing: Text(
                '₹ 5000',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,fontFamily: "Roboto"),
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 5.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 3.5, color: Colors.white24))),
                child: new CircleAvatar(
                  child: Text(
                    '₹',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  backgroundColor: Color(0xFFEFEBE9),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            ),
            new ListTile(
              title: Text(
                'Fraterninty Amount',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
              ),
              trailing: Text(
                '₹ 2000',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,fontFamily: "Roboto"),
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 5.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 3.5, color: Colors.white24))),
                child: new CircleAvatar(
                  child: Text(
                    '₹',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  backgroundColor: Color(0xFFEFEBE9),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            ),
            new ListTile(
              title: Text(
                'Fine Amount',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
              ),
              trailing: Text(
                '₹ 500',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,fontFamily: "Roboto"),
              ),
              leading: Container(
                padding: EdgeInsets.only(right: 5.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 3.5, color: Colors.white24))),
                child: new CircleAvatar(
                  child: Text(
                    '₹',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  backgroundColor: Color(0xFFEFEBE9),
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: new Divider(),
            ),
          ],
        ),
      ),
      onWillPop: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Home()));
      },
    );
  }
}
