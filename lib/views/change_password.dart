import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/presenter/changepassword_presenter.dart';
import 'package:ima_connect_app/utils/app_constants.dart';
import 'package:ima_connect_app/views/home.dart';

class ChangePassword extends StatefulWidget {
  final int uid;
  final String token;
  final String username;
  ChangePassword({Key key, this.uid, this.token,this.username}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _ChangePassword();
}

class _ChangePassword extends State<ChangePassword>
    implements Changepasswordcontract {
  
  final formKey = new GlobalKey<FormState>();
  String  _currentpwd, _newpwd, _confirmpwd;
  TextEditingController _currentpwdCtrl = new TextEditingController();
  TextEditingController _newpwdCtrl = new TextEditingController();
  TextEditingController _confirmpwdCtrl = new TextEditingController();
  ChangepasswordPresenter _presenter;

  bool _isLoading;
  _ChangePassword() {
    _presenter = new ChangepasswordPresenter(this);
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.0),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Home()));
                }),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search, color: Colors.black, size: 25.0),
                  onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Change Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: "Raleway")),
            ),
          ),
          bottomNavigationBar: new Stack(
            overflow: Overflow.visible,
            alignment: new FractionalOffset(.5, 1.0),
            children: [
              new Container(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.all(16),
                  color: Colors.indigo,
                  child: Text("CONFIRM",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onPressed: () {
                    _submit();
                  },
                ),
              ),
            ],
          ),
          body: new Form(
            key: formKey,
            child: Container(
              decoration: new BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new ListView(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    TextFormField(
                      enabled: false, 
                      initialValue:widget.username,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        ),
                    SizedBox(height: 15.0),
                    TextFormField(
                        controller: _currentpwdCtrl,
                        onSaved: (val) => _currentpwd = val,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Current Password",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Current Password required';
                          }
                        }),
                    SizedBox(height: 15.0),
                    TextFormField(
                        onSaved: (val) => _newpwd = val,
                        controller: _newpwdCtrl,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "New Password",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'New Password required';
                          }
                        }),
                    SizedBox(height: 15.0),
                    TextFormField(
                        onSaved: (val) => _confirmpwd = val,
                        controller: _confirmpwdCtrl,
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Confirm Password required';
                          }
                        }),
                  ],
                ),
              ),
            ),
          )),
      onWillPop: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Home()));
      },
    );
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        if (_newpwd != _confirmpwd) {
          _showSnackBar('New Password does not match the confirm password');
        } else if (_currentpwd == _newpwd) {
          _showSnackBar('New Password should not be same as Old Password');
        } else {
          var requestBody = {
            "user_id": widget.uid,
            "email": widget.username,
            "currentPaswd": _currentpwd,
            "newpaswd": _newpwd,
            "confirmpaswd": _newpwd
          };
          _presenter.doChangePassword(requestBody, widget.token);
        }
      });
    }
  }

  @override
  void onChangePasswordError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onChangePasswordSuccess(HttpResponseModel httpresponse) {
    if (httpresponse.responseCode == ResponseCode.SUCCESS) {
       setState(() {
          _isLoading = false;
          _confirmpwdCtrl.text = "";
          _newpwdCtrl.text = "";
          _currentpwdCtrl.text = "";
        });
      _showSnackBar('PasswordChanged Sucessfully');
   
    } else {
      if (httpresponse.responseCode == ResponseCode.WARNING) {
        setState(() {
          _isLoading = false;
          _confirmpwdCtrl.text = "";
          _newpwdCtrl.text = "";
          _currentpwdCtrl.text = "";
        });
        _showSnackBar(httpresponse.responseMessage);
      }
    }
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
}
