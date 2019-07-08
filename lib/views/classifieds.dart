import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../views/home.dart';
//import 'package:ima_connect_app/font_icons/custom_icons.dart';
import '../model/classified.dart';
import '../presenter/classified_presenter.dart';

class Classifieds extends StatefulWidget {
  _ClassifiedsState createState() => _ClassifiedsState();
}

class _ClassifiedsState extends State<Classifieds>
    implements ClassifiedsContract {
  @override
  void initState() {
    super.initState();
    _loadClassifieds();
  }

  ClassifiedsPresenter _presenter;
  _ClassifiedsState() {
    _presenter = new ClassifiedsPresenter(this);
  }

  //final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  String _color = '';
  List<Classified> _clsList = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          child:  DefaultTabController(
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
                        // Navigator.of(context).pop(true);
                      })),
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "View Classifieds",
                      style: TextStyle(
                          color: Colors.indigo, 
                          fontFamily: "Raleway"                      
                          ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Post Classifieds",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: "Raleway"
                          ),
                    ),
                  ),
                ],
              ),
              title: Text(
                'Classifieds',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Raleway"                                
                    ),
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
                                 _clsList.length > 0 ? Text(
                                    "Total " +
                                        _clsList.length.toString() +
                                        " Result found",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ) :new Container(),
                                  IconButton(
                                    icon: new SvgPicture.asset(
                                      "assets/images/filter.svg",
                                       color: Colors.black,
                                       height: 25,
                                     ),
                                    onPressed: () {
                                      _settingModalBottomSheet(context);
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
                        child: _viewClassifieds(),
                      ),
                    ],
                  ),
                  postClassifieds()
                ],
              ),
            ),
          ),
        ),
       onWillPop: () {
         Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context) => new Home()));
      },
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.close),
                  title: new Text('Filter'),
                  trailing: Text("Clear All"),
                ),
                new Divider(),
                new Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              // icon: const Icon(Icons.color_lens),
                              labelText: 'Select Category',
                            ),
                            isEmpty: _color == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _color,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    //  newContact.favoriteColor = newValue;
                                    _color = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _colors.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              // icon: const Icon(Icons.color_lens),
                              labelText: 'Select SubCategory',
                            ),
                            isEmpty: _color == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _color,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    //  newContact.favoriteColor = newValue;
                                    _color = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _colors.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                      new FormField(
                        builder: (FormFieldState state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              // icon: const Icon(Icons.color_lens),
                              labelText: 'Select Location',
                            ),
                            isEmpty: _color == '',
                            child: new DropdownButtonHideUnderline(
                              child: new DropdownButton(
                                value: _color,
                                isDense: true,
                                onChanged: (String newValue) {
                                  setState(() {
                                    //  newContact.favoriteColor = newValue;
                                    _color = newValue;
                                    state.didChange(newValue);
                                  });
                                },
                                items: _colors.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: FlatButton(
                    color: Colors.indigo,
                    child: Text('APPLY',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white)),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget postClassifieds() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        new Wrap(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          labelText: 'Select Category',
                        ),
                        isEmpty: _color == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _color,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                //  newContact.favoriteColor = newValue;
                                _color = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _colors.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          labelText: 'Select SubCategory',
                        ),
                        isEmpty: _color == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _color,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                //  newContact.favoriteColor = newValue;
                                _color = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _colors.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          // icon: const Icon(Icons.color_lens),
                          labelText: 'Select Location',
                        ),
                        isEmpty: _color == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _color,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                //  newContact.favoriteColor = newValue;
                                _color = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _colors.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Contacts",
                      //filled: true
                    ),
                    validator: (value) {
                      if (value.length == 0) {
                        return ('Contacts not Empty');
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text("Upload Images"),
                    ),
                  )
                ],
              ),
            ),
            //     Row(
            //    children: <Widget>[
            //     Expanded(
            //       child: Padding(
            //         padding: EdgeInsets.only(top:20),
            //                     child: RaisedButton(
            //           color: Colors.indigo,
            //           child: Text("APPLY",style: TextStyle(fontWeight: FontWeight.normal,fontSize:15,color:Colors.white )),
            //         ),
            //       ),
            //     ),
            //    ]
            //  )
          ],
        ),
      ],
    );
  }

  Widget _viewClassifieds() {
    return _clsList.length > 0
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
                    leading: Container(
                      width: 50,
                      height: 50,
                      //padding: EdgeInsets.only(right: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(
                            'https://images.unsplash.com/photo-1474823310278-5c40989a3fd5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                      ),
                    ),
                    title: Text(_clsList[index].postedDate.toString(),
                        style: TextStyle(color: Colors.black54, fontSize: 14)),
                    subtitle: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(_clsList[index].subject.toString(),
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
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.black54))),
                                  // tag: 'hero',
                                  child: Text("Posted by",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14
                                         )),
                                )),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      _clsList[index].postedBy.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14))),
                            )
                          ],
                        )
                      ],
                    ),
                    trailing: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Icon(Icons.keyboard_arrow_right,
                            color: Colors.black54, size: 20.0)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClassifiedDtlsPage(
                                    cls: _clsList[index],
                                  )));
                    },
                  )
                ],
              );
            })
        : new Center(
            child: new CircularProgressIndicator(),
          );
  }


  @override
  void onClassifiedslistError(String error) {
    print('$error');
  }

  @override
  void onClassifiedslistSuccess(List<Classified> cls) {
    setState(() {
      _clsList = cls;
    });
  }

  _loadClassifieds() {
    _presenter.doClassifiedsList();
  }

  @override
    void dispose()
    {
      super.dispose();
    }
}

class ClassifiedDtlsPage extends StatefulWidget {
  final Classified cls;
  ClassifiedDtlsPage({Key key, this.cls}) : super(key: key);
  @override
  _ClassifiedDtlsPageState createState() => new _ClassifiedDtlsPageState();
}

class _ClassifiedDtlsPageState extends State<ClassifiedDtlsPage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = new Container(
      //height: 200.0,
      height: MediaQuery.of(context).size.height * .30,
      child: new SizedBox(
          height: MediaQuery.of(context).size.height * .30,
          width: MediaQuery.of(context).size.width,
          child: new Carousel(
            images: [
              new NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
              new NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              new NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
              new NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
              new NetworkImage(
                  'https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
            ],
            showIndicator: true,
            borderRadius: false,
            noRadiusForIndicator: true,
          )),
    );
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                //expandedHeight: 200.0,
                backgroundColor: Colors.white,
               leading: Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: 20.0),
                      onPressed: () {
                         Navigator.of(context).pop(true);
                      })),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  //centerTitle: true,
                  title: Text("Classifieds",
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
          body: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  new ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        imageCarousel,
                        new ListTile(
                            title: Text(widget.cls.postedBy),
                            subtitle: Column(
                              children: <Widget>[
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child:Text("Samsung Galaxy",style: TextStyle(fontWeight: FontWeight.bold,fontSize:12,color: Colors.black)),
                                // ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          // decoration: new BoxDecoration(
                                          //     border: new Border(
                                          //         right: new BorderSide(width: 1.0, color: Colors.black54))),
                                          // tag: 'hero',
                                          child: Text(
                                              "Posted on " +
                                                  widget.cls.postedDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12)),
                                        )),
                                    // Expanded(
                                    //   flex: 6,
                                    //   child: Padding(
                                    //       padding: EdgeInsets.only(left: 10.0),
                                    //       child: Text("14 Mar 2019",
                                    //           style: TextStyle(fontWeight: FontWeight.normal,fontSize:12))),
                                    // )
                                  ],
                                )
                              ],
                            ),
                            leading: Container(
                                padding: EdgeInsets.only(right: 5.0),
                                child: CircleAvatar(
                                  child: Text("C"),
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                )),
                            //trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 20.0),
                            onTap: () {}),
                        Container(
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          child: new Divider(),
                        ),
                        ListTile(
                          title: RichText(
                            text: TextSpan(
                              text: '₹ ',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '35000',
                                    style: TextStyle(color: Colors.orange)),
                                TextSpan(
                                    text: '/-',
                                    style: TextStyle(color: Colors.orange)),
                              ],
                            ),
                          ),
                          //title: Text("₹ 35000/-",style: TextStyle(fontWeight: FontWeight.normal,fontSize:20,color:Colors.orange )),
                          subtitle: Text(widget.cls.subject,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black)),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          child: new Divider(),
                        ),
                        ListTile(
                          // leading: Text("35000/-",style: TextStyle(fontWeight: FontWeight.normal,fontSize:20,color:Colors.orange )),
                          title: Text("Brand",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Colors.grey)),
                          subtitle: Text("Samsung",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black)),
                        ),
                        ListTile(
                          // leading: Text("35000/-",style: TextStyle(fontWeight: FontWeight.normal,fontSize:20,color:Colors.orange )),
                          title: Text("Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Colors.grey)),
                          subtitle: Text("Ernakulam",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black)),
                        ),
                      ]),
                  // Container(
                  //     // This align moves the children to the bottom
                  //     child: Align(
                  //         alignment: FractionalOffset.bottomCenter,
                  //         // This container holds all the children that will be aligned
                  //         // on the bottom and should not scroll with the above ListView
                  //         child: Container(
                  //             // padding: EdgeInsets.only(left:5.0),
                  //             child: Row(
                  //           children: <Widget>[
                  //             SizedBox(
                  //               width: MediaQuery.of(context).size.width * .5,
                  //               height: 50,
                  //               child: RaisedButton(
                  //                 color: Colors.indigo,
                  //                 child: Text('MESSAGE',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.normal,
                  //                         fontSize: 15,
                  //                         color: Colors.white)),
                  //                 onPressed: () {
                  //                   // Perform some action
                  //                 },
                  //               ),
                  //             ),
                  //             SizedBox(
                  //               width: MediaQuery.of(context).size.width * .5,
                  //               height: 50,
                  //               child: RaisedButton(
                  //                 color: Colors.indigo,
                  //                 child: Text('CALL',
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.normal,
                  //                         fontSize: 15,
                  //                         color: Colors.white)),
                  //                 onPressed: () {
                  //                   // Perform some action
                  //                 },
                  //               ),
                  //             )
                  //           ],
                  //         ))))
                ],
              ))),
      // bottomNavigationBar: Stack(
      //   children: <Widget>[],
      // ),
    );

    
  }
}
