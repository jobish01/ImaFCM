import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/login.dart';

// void main() => runApp(IMAConnectApp());
void main() { SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); runApp(new IMAConnectApp()); }
class IMAConnectApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'imaConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Raleway'
      ),
      home: SplashScreen(),
    );
  }
}


class SplashScreen extends StatefulWidget
{
  _SplashScreenState createState()=>new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    )..forward();

    _animation = CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
        reverseCurve: Curves.fastOutSlowIn
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.dismissed)
        _controller.forward();
      else if (status == AnimationStatus.completed)      
          {         
            Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
            (new LoginPage()
            )));
      }
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  Widget _buildIndicators(BuildContext context, Widget child) {
    final List<Widget> indicators = <Widget>[
      LinearProgressIndicator(value: _animation.value,backgroundColor: Colors.white,),
    ];
    return Column(
      children: indicators
          .map<Widget>((Widget c) => Container(child: c, margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0)))
          .toList(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color:Colors.white),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex:2 ,
                  child: Container(
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                        new Center(
                          child: CircleAvatar(
                              backgroundColor:Colors.white,
                              radius: 50.0,
                              child: Image.asset('assets/images/ima.jpg')
                          ),
                        ),
                        Padding(padding:EdgeInsets.only(top:10.0),),
                        Text("KERALA",style: new TextStyle(fontSize:16,color: Colors.indigo,fontStyle: FontStyle.normal),),
                        Padding(padding:EdgeInsets.only(top:15.0),),
                        Text("Welcome to",style: new TextStyle(fontSize:12,color: Colors.grey,),),
                        Padding(padding:EdgeInsets.only(top:5.0),),
                        Text("imaConnect",style: new TextStyle(fontSize:22,color: Colors.black,fontWeight:FontWeight.bold ),),
                      ],
                    ),
                  ),),
                Padding(
                  padding:const EdgeInsets.only(top:10),
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: _buildIndicators
                 ),
               )
              ],
            ),
          ],
        )
    );
  }
}