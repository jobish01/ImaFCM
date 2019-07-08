import 'package:flutter/material.dart';
import 'package:ima_connect_app/model/concern_model.dart';
import 'package:ima_connect_app/service/ConcernService/concern_service.dart';
//import 'package:intl/intl.dart';

class ConcersView extends StatefulWidget {
  @override
  _ConcersViewState createState() => _ConcersViewState();
}

class _ConcersViewState extends State<ConcersView> {
  bool isLoading = false;
  final FocusNode focusNode = new FocusNode();
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  var listMessage = new List<Concern>();
  int id = 1;

  var bloc = new ConcernBloc();
  @override
  Widget build(BuildContext context) {
    var reqData = {"id": "1"};
    bloc.query.add(reqData);
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
          title: Text("Concerns",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: "Raleway")), 
                   leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: Colors.black, size: 20.0),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Input content
              buildInput(),
            ],
          ),
          buildLoading()
        ],
      ),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: Colors.grey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  void onSendMessage(String content, int type) {}

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder(
        stream: bloc.allConcerns,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)));
          } else {
            listMessage = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildItem(index, snapshot.data[index]),
              itemCount: snapshot.data.length,
              reverse: true,
              controller: listScrollController,
            );
          }
        },
      ),
    );
  }

  Widget buildItem(int index, Concern document) {
    if (document.msgUserId == id) {
      // Right (my message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        document.subject,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        document.message,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.cyan, borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                ),
                
                // Sticker
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
             // Time
            isLastMessageRight(index)
                ? Container(
                  child: Text("data"),
                    // child: Text(
                    //   DateFormat('dd MMM kk:mm').format(document.sentDate),
                    //   style: TextStyle(
                    //       color: Colors.green,
                    //       fontSize: 12.0,
                    //       fontStyle: FontStyle.italic),
                    // ),
                    margin: EdgeInsets.only(left: 50.0, bottom: 5.0),
                  )
                : Container()
          ],
         mainAxisAlignment: MainAxisAlignment.end, 
        ),
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text(
                                document.subject,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                document.message,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(left: 10.0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                  child: Text("data"),
                    // child: Text(
                    //   DateFormat('dd MMM kk:mm').format(document.sentDate),
                    //   style: TextStyle(
                    //       color: Colors.green,
                    //       fontSize: 12.0,
                    //       fontStyle: FontStyle.italic),
                    // ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].msgUserId == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].msgUserId != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}
