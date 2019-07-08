import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ima_connect_app/model/CustomPainter.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/utils/app_constants.dart';
import '../model/profile.dart';
import '../presenter/profile_presenter.dart';
//import 'package:cached_network_image/cached_network_image.dart';
class ProfilePage extends StatefulWidget {
  
  final int uid;
  final String token;
  ProfilePage({Key key,@required this.uid,@required this.token}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfilePage> implements ProfileContract {

  TextEditingController fNameController  =TextEditingController();
  TextEditingController lNameController  =TextEditingController();
  TextEditingController mbController  =TextEditingController();
  TextEditingController emailController  =TextEditingController();
  TextEditingController designController  =TextEditingController();
  TextEditingController distController  =TextEditingController();
  TextEditingController mTypeController  =TextEditingController();

   ProfilePresenter _presenter;
  _ProfileState() {
    _presenter = new ProfilePresenter(this);
  }

  bool _isLoad=false;
   double percentage;
  @override
  void initState() {
    super.initState();
    onLoadProfileData();
    fNameController.text="";
    lNameController.text="";
    mbController.text="";
    emailController.text="";
    designController.text="";
    distController.text="";
    mTypeController.text="";
    percentage = 0.0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _profileAvatar() {
    return new Center(
      child: new Container(
        height: 120.0,
        width: 120.0,
        child: new CustomPaint(
          foregroundPainter: new MyPainter(
              lineColor: Colors.amber,
              completeColor: Colors.blueAccent,
              completePercent: 100,
              width: 2.0
          ),
          child: new Padding(
            padding: const EdgeInsets.all(6.0),
             child: CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/images/dp.png'),
                                radius: 15)
            // child:CircleAvatar(backgroundImage:NetworkImage(
            //                'https://images.unsplash.com/photo-1500043471691-62605d884af8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),)
          // child:CircleAvatar(child:CachedNetworkImage(
          //   imageUrl: 'https://images.unsplash.com/photo-1500043471691-62605d884af8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60',
          //   placeholder: (context, url) => new CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation(Colors.grey),),
          //   errorWidget: (context, url, error) => new Icon(Icons.error),
          // ),backgroundColor: Colors.white,)
          ),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //expandedHeight: 200.0,
              backgroundColor: Colors.white,
              leading:Container(
                padding: EdgeInsets.only(right: 5.0),
                child:IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0), onPressed: (){ Navigator.of(context).pop(true);})
            ),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  //centerTitle: true,
                  title: Text("My Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
//                  background: Image.network(
////                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
////                    fit: BoxFit.cover,
////                  )
              ),
            ),
          ];
        },
        body:_isLoad ? Container(
            color: Colors.white,
            child:new SafeArea(child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: new ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: _profileAvatar(),
                      padding: EdgeInsets.only(top:2),
                    ),
                    new ListTile(
                      title: TextField(
                        enabled: false,
                        controller: fNameController,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "First Name",
                        ),
                      ),
                    ),
                    // new ListTile(
                    //   title: TextField(
                    //     enabled: false,
                    //     controller: lNameController,
                    //     style: TextStyle(fontSize: 12, color: Colors.black),
                    //     decoration: InputDecoration(
                    //       labelText: "Last Name",
                    //     ),
                    //   ),
                    // ),
                    new ListTile(
                      title: TextField(
                        enabled: false,
                        controller: mbController,
                        style: TextStyle(fontSize: 12, color: Colors.black,),
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
                        ),
                      ),
                    ),
                    new ListTile(
                      title: TextField(
                        enabled: false,
                        controller: emailController,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                      ),
                    ),
                    new ListTile(
                      title: TextField(
                        enabled: false,
                        controller: designController,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Designation",
                        ),
                      ),
                    ),
                    new ListTile(
                      title: TextField(
                        enabled: false,
                        controller: distController,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "District",
                        ),
                      ),
                    ),
                    new ListTile(
                      title: TextField(
                        enabled: false,
                        controller: mTypeController,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        decoration: InputDecoration(
                          labelText: "Membership Type",
                        ),
                      ),
                    ),
                  ]),))) :new Center(
                    child: CircularProgressIndicator(),
                  )
      ),
    );
  }

  @override
  void onProfileDataError(String error) {
   setState(() {
    _isLoad=false; 
   });
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
  void onProfileDataSuccess(HttpResponseModel httpResp) {
    if (httpResp.responseCode == ResponseCode.SUCCESS) {
      Profile profile = new Profile.fromJson(httpResp.response);
   setState(() {
     _isLoad=true;
    fNameController.text=profile.membername;
    lNameController.text="";
    mbController.text=profile.mobileNumber;
    emailController.text=profile.mail;
    designController.text=profile.designationName;
    distController.text=profile.address[0].post;
    mTypeController.text=profile.membershiptypename; 
   });
  }
}

 onLoadProfileData()
  {
    _presenter.doProfileData(widget.uid.toString(),widget.token.toString());
  }
}

