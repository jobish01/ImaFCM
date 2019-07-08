import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/utils/app_constants.dart';
//import 'package:ima_connect_app/model/httpResponseModel.dart';
import '../views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/authentication.dart';
import '../presenter/login_presenter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  //bool _rememberMeFlag = false;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final formKeyforgot = new GlobalKey<FormState>();
  SharedPreferences prefs;
  String _username, _password;
  TextEditingController _userNameCtrl = new TextEditingController();
  TextEditingController _pwdCtrl = new TextEditingController();
  TextEditingController _emailCtrl = new TextEditingController();
  LoginPagePresenter _presenter;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _messaging.configure(
     onMessage: (Map<String,dynamic>message){},
     onResume: (Map<String,dynamic>message){},
     onLaunch: (Map<String,dynamic>message){},
    );
    _messaging.getToken().then((token){
    print(token);
  });

  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'ima',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/ima.jpg'),
      ),
    );
    final kerala = Center(
      child: Text(
        'KERALA',
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
    final signinText = Center(
        child: Text(
      'Sign in to Continue',
      textDirection: TextDirection.ltr,
      style: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
    ));
    final userName = TextFormField(
      controller: _userNameCtrl,
      autofocus: false,
      onSaved: (val) => _username = val,
      decoration: InputDecoration(
        labelText: 'User Name',
        prefixIcon: Icon(Icons.account_circle),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Username required';
        }
      },
    );

    final password = TextFormField(
      style: TextStyle(color: Colors.black),
      controller: _pwdCtrl,
      autofocus: false,
      obscureText: true,
      onSaved: (val) => _password = val,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Password required';
        }
      },
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          _submit();
        },
        padding: EdgeInsets.all(15),
        color: Colors.indigo,
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
      ),
    );

    return WillPopScope(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: new Form(
              key: formKey,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    logo,
                    kerala,
                    signinText,
                    SizedBox(height: 48.0),
                    userName,
                    SizedBox(height: 8.0),
                    password,
                    SizedBox(height: 24.0),
                    loginButton,
                    _isLoading
                        ? Align(
                            alignment: FractionalOffset.center,
                            child: CircularProgressIndicator(),
                          )
                        : new Container()
                  ],
                ),
              ),
            )),
        onWillPop: () {
          _exitApp(context);
        });
  }

  Future<bool> _exitApp(BuildContext context) async {
    return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return new CupertinoAlertDialog(
                title: new Column(
                  children: <Widget>[
                    new Text("Are you Sure to exit"),
                    // new Icon(Icons.add_to_home_screen,color: Colors.blue,)
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        exit(0);
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

  @override
  void dispose() {
    super.dispose();
    _presenter = null;
  }

  void _submit() {
    // _connectionStatus.check().then((c)
    //  {
    //   if(c==false)
    //   {

    //   }
    //   else
    //   {
    //     _showSnackBar("No Network connection");
    //   }
    //  });

    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  // void _forgotsubmit() {
  //   final form = formKeyforgot.currentState;
  //   if (form.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //       form.save();
  //       _presenter.doForgotPassword(_emailId);
  //       Navigator.of(context).pop();
  //       // if (_emailId == null) {
  //       //   return 'EmailId required';
  //       // } else {
  //       //   _presenter.doForgotPassword(_emailId);
  //       // }
  //     });
  //   }
  // }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onForgotPasswordError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  // @override
  // void onLoginSuccess(Authentication auth) {
  //   if (auth.idUser > 0) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     storeKeys(auth);
  //     Navigator.of(context).push(
  //         new MaterialPageRoute(builder: (BuildContext context) => new Home()));
  //   } else {
  //     setState(() {
  //       _isLoading = false;
  //       _userNameCtrl.text = "";
  //       _pwdCtrl.text = "";
  //     });
  //     _showSnackBar("Invalid UserName or Password");
  //   }
  // }

  void onLoginSuccess(HttpResponseModel httpresponse) {
    if (httpresponse.responseCode == ResponseCode.SUCCESS) {
      Authentication auth = new Authentication.fromJson(httpresponse.response);
      if (auth.token != " " || auth.token != null) {
        setState(() {
          _isLoading = false;
        });
        storeKeys(auth);
        
      }
    } else {
      if (httpresponse.responseCode == ResponseCode.WARNING) {
        setState(() {
          _isLoading = false;
          _userNameCtrl.text = "";
          _pwdCtrl.text = "";
        });
        _showSnackBar(httpresponse.responseMessage);
      }
    }
  }

  @override
  void onForgotPasswordSuccess(int responseCode) {
    if (responseCode > 0) {
      setState(() {
        _isLoading = false;
        _emailCtrl.text = "";
        _showSnackBar("Password sent to your email.");
      });
    } else {
      setState(() {
        _isLoading = false;
        _emailCtrl.text = "";
      });
      _showSnackBar("Mail Id is not registered");
    }
  }

  storeKeys(Authentication auth) async {
    String desgn = "";
     String schmeApprovalstatus = "";
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _username);
    await prefs.setString('uName', auth.uName);
    await prefs.setInt('iduser', auth.idUser);
    await prefs.setString('desgn', desgn);
    await prefs.setString('schmeApprovalstatus', schmeApprovalstatus);
    await prefs.setString('token', auth.token);
    await prefs.setString("role", auth.role);
    await prefs.setString('levelTable', auth.levelTable);
    await prefs.setInt('level', auth.level);
    await prefs.setInt('membershipType', auth.membershipType);
    await prefs.setInt('branchCode', auth.branchCode);
    await prefs.setString('profileImage', auth.profileImage);
    Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Home()));
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

  // Future<void> _forgotpassword() {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext contex) {
  //         return Form(
  //           key: formKeyforgot,
  //           child: AlertDialog(
  //             title: Text('Forgot your password?',
  //                 style: TextStyle(
  //                     color: Colors.black, fontWeight: FontWeight.bold)),
  //             content: Container(
  //               child: TextFormField(
  //                 keyboardType: TextInputType.emailAddress,
  //                 controller: _emailCtrl,
  //                 onSaved: (val) => _emailId = val,
  //                 decoration: InputDecoration(labelText: 'EmailId'),
  //                 validator: (value) {
  //                   if (value.isEmpty) {
  //                     return 'EmailId required';
  //                   }
  //                 },
  //               ),
  //             ),
  //             actions: <Widget>[
  //               RaisedButton(
  //                 child: Text(
  //                   'Get Password',
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //                 onPressed: () {
  //                   _forgotsubmit();
  //                 },
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }

}
