import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ima_connect_app/model/concern_model.dart';
import 'package:ima_connect_app/model/httpResponseModel.dart';
import 'package:ima_connect_app/presenter/concern_presenter.dart';
import 'package:ima_connect_app/utils/app_constants.dart';
import 'package:ima_connect_app/views/home.dart';

class ConsernsList extends StatefulWidget {
  final Widget child;
  final int userId;
  final int branchId;
  final String token;

  ConsernsList({Key key, this.child, this.userId, this.branchId, this.token})
      : super(key: key);

  _ConsernsListState createState() => _ConsernsListState();
}

class _ConsernsListState extends State<ConsernsList>
    implements ConcernContract {
  @override
  void initState() {
    super.initState();
    loadConcernList();
  }

  ConcernPresenter _presenter;
  _ConsernsListState() {
    _presenter = new ConcernPresenter(this);
  }
  List<Concern> _clsList = [];
  var _isLoading = RequestStatus.InProgress;
  int checkValue = 0;

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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new Home()));
                    })),
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "View Concerns",
                    style:
                        TextStyle(color: Colors.indigo, fontFamily: "Raleway"),
                  ),
                ),
                Tab(
                  child: Text(
                    "Raise Concern",
                    style:
                        TextStyle(color: Colors.indigo, fontFamily: "Raleway"),
                  ),
                ),
              ],
            ),
            title: Text(
              'Concerns',
              style: TextStyle(color: Colors.black, fontFamily: "Raleway"),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: TabBarView(
              children: [
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.topCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * .1,
                        color: Colors.white,
                        padding: EdgeInsets.only(bottom: 10, left: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _clsList.length > 0
                                    ? Text(
                                        "Total " +
                                            _clsList.length.toString() +
                                            " Result found",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      )
                                    : new Container(),
                                IconButton(
                                  icon: new SvgPicture.asset(
                                    "assets/images/filter.svg",
                                    color: Colors.black,
                                    height: 25,
                                  ),
                                  onPressed: () {
                                    // _settingModalBottomSheet(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .1,
                      ),
                      child: _viewConcerns(),
                    ),
                  ],
                ),
                 raiseConcerns()
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

  Widget _viewConcerns() {
    return _isLoading == RequestStatus.Found
        ? ListView.separated(
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: new Divider(),
                ),
            itemCount: _clsList.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  new ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    leading:_clsList[index].profilepic== "" ? CircleAvatar(
                                backgroundImage:
                                    ExactAssetImage('assets/images/dp.png'),
                                radius: 15) : Image.network(_clsList[index].profilepic),
                    // Container(
                    //   width: 50,
                    //   height: 50,
                    //   //padding: EdgeInsets.only(right: 12.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.indigo,
                    //     borderRadius: BorderRadius.all(Radius.circular(15)),
                    //   ),
                      
                    //   // child: FittedBox(
                    //   //   fit: BoxFit.fill,
                    //   //   child: Image.network(
                    //   //       'https://images.unsplash.com/photo-1474823310278-5c40989a3fd5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                    //   // ),
                    // ),
                    title: Text(_clsList[index].subject,
                        style: TextStyle(color: Colors.black54, fontSize: 14)),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(_clsList[index].username.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black)),
                            )),
                        Row(
                          children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                  // decoration: new BoxDecoration(
                                  //     border: new Border(
                                  //         right: new BorderSide(
                                  //             width: 1.0,
                                  //             color: Colors.black54))),
                                  // tag: 'hero',
                                  child: Text(_clsList[index].strdate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14)),
                                )),
                            // Expanded(
                            //   flex: 4,
                            //   child: Padding(
                            //       padding: EdgeInsets.only(left: 10.0),
                            //       child: Text(
                            //           _clsList[index].msgUserId.toString(),
                            //           style: TextStyle(
                            //               fontWeight: FontWeight.normal,
                            //               fontSize: 14))),
                            // )
                          ],
                        )
                      ],
                    ),
                    trailing: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Icon(Icons.keyboard_arrow_right,
                            color: Colors.black54, size: 20.0)),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ClassifiedDtlsPage(
                      //               cls: _clsList[index],
                      //             )));
                    },
                  )
                ],
              );
            })
        :  new Center(
                  child: _isLoading == RequestStatus.InProgress
                      ? new CircularProgressIndicator()
                      : Text(
                          "No Concerns",
                          style: TextStyle(color: Colors.indigo),
                        ),
                );
  }

    Widget raiseConcerns() {
      return Center(child: Text("Raise concerns"));
  }


  loadConcernList() {
    _presenter.doConcernList(widget.userId, widget.branchId.toString(), 0, widget.token);
  }

  @override
  void onConcernsListError(String error) {
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
  void onConcernsListSuccess(HttpResponseModel httpRep) {
    if (httpRep.responseCode == ResponseCode.SUCCESS) {
      List concernsList = httpRep.response;
      List<Concern> _concerList=[];
     _concerList =concernsList.map((resRaw) => Concern.fromJson(resRaw)).toList();
      setState(() {
        if (_concerList.length > 0) {
          _clsList = _concerList;
          _isLoading =RequestStatus.Found;
        } else {
          _isLoading = RequestStatus.NullData;
        }
      });
    }
  }
}
