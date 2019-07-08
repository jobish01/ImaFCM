import 'package:flutter/material.dart';
import 'package:ima_connect_app/views/payments.dart';
import '../views/classifieds.dart';
import '../views/dash_board.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DashBoard(),
    Classifieds(),
    //PaymentList()
    Payment()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  // Future<bool> _exitApp(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     child: new AlertDialog(
  //       title: new Text('Do you want to exit this application?'),
  //       content: new Text('We hate to see you leave...'),
  //       actions: <Widget>[
  //         new FlatButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: new Text('No'),
  //         ),
  //         new FlatButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: new Text('Yes'),
  //         ),
  //       ],
  //     ),
  //   ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon:_currentIndex==0 ? new SvgPicture.asset("assets/images/home_active.svg",height: 25,color: Colors.indigo,) :new SvgPicture.asset("assets/images/home_active.svg",height: 25,color: Colors.grey,),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon:_currentIndex==1 ? new SvgPicture.asset("assets/images/classifieds_active.svg",color: Colors.indigo,height: 25,):new SvgPicture.asset("assets/images/classifieds_active.svg",color: Colors.grey,height: 25,),
            title: Text('Classifieds'),
          ),
          new BottomNavigationBarItem(
              icon:_currentIndex==2 ?new SvgPicture.asset("assets/images/payments_active.svg",color: Colors.indigo,height: 25,):new SvgPicture.asset("assets/images/payments_active.svg",color: Colors.grey,height: 25,),
              title: Text('Payments'),
          ),
            // BottomNavigationBarItem(
            //  icon:_currentIndex==3 ?  new SvgPicture.asset("assets/images/membership_active.svg",color: Colors.indigo,height: 25,):new SvgPicture.asset("assets/images/membership_active.svg",color: Colors.grey,height: 25,),
            //   title: Text("Membership"))
        ],
      ),
    );   
  }
}