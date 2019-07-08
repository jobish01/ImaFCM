import 'package:flutter/material.dart';
import 'package:ima_connect_app/model/profile.dart';
class MemberApprovalDetails extends StatefulWidget {
  final Profile profile;

  MemberApprovalDetails({Key key, this.profile}) : super(key: key);

  @override
  MemberApprovalDetailsState createState() => new MemberApprovalDetailsState();
}
class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Widget iconpic;
  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}
class MemberApprovalDetailsState extends State<MemberApprovalDetails> {
  
  // init the step to 0th position
  bool isAction = false;
  int currentStep = 0;
  //Profile widget.profile=new Profile();

  // MemberApprovalPresenter _presenter;
  // MemberApprovalDetailsState() {
  //   _presenter = new MemberApprovalPresenter(this);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // final theme = Theme.of(context).copyWith(dividerColor: Colors.white);
      List<Step> _memberApprovals() {
    List<Step> msteps = [
      new Step(
          title: new Text(""),
          content: new Column(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text("Membership Details",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.indigo,
                           )),
                  )),
                  new Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: new ExpansionTile(
                      title: new Text("Persional Details"),
                      leading: CircleAvatar(
                      child: Icon(Icons.account_circle),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 40.0),
                          child: new Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 20),
                          //child: Text("data"),
                          child: Table(
                              defaultColumnWidth: const FlexColumnWidth(1.0),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.top,
                              // columnWidths: {1:FractionColumnWidth(10)},
                              children: [
                                TableRow(
                                  children: [
                                    Text("Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.membername,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                 TableRow(
                                  children: [
                                    Text("Father/spouse",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.faorhusname,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                
                                TableRow(
                                  children: [
                                    Text("Gender",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.sex,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                // TableRow(children: [
                                //   Text("Relation"),
                                //   Text("Father"),
                                // ]),
                                // TableRow(children: [
                                //   Text("Gender"),
                                //  // Text(widget.profile?.sex),
                                // ]),
                                TableRow(
                                  children: [
                                    Text("Maritial Status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.maritialstatus == true ? "Married" :"Single",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                 TableRow(
                                  children: [
                                    Text("Gender",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.sex,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                 TableRow(
                                  children: [
                                    Text("Membership Type",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.membershiptypename,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                        
                              ]),
                    ),]),
                  ),              
              SizedBox(
                height: 10,
              ),
              new Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child:new ExpansionTile(                 
                      title: new Text("Permenant Address"),
                      leading: CircleAvatar(
                        child: Icon(Icons.location_on),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 40.0),
                          child: new Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 20),
                          child: Table(
                              defaultColumnWidth: const FlexColumnWidth(1.0),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.top,
                              // columnWidths: {1:FractionColumnWidth(10)},
                              children: [
                                TableRow(
                                  children: [
                                    Text("House Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.address[0].houseName == null ? " " :widget.profile?.address[0].houseName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                 TableRow(
                                  children: [
                                    Text("Street",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.address[0].streetName == null ? " " :widget.profile?.address[0].streetName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                              ])
                          // child: Table(
                          //     defaultColumnWidth: const FlexColumnWidth(1.0),
                          //     defaultVerticalAlignment:
                          //         TableCellVerticalAlignment.top,
                          //     // columnWidths: {1:FractionColumnWidth(10)},
                          //     children: [
                          //       TableRow(
                          //         children: [
                          //           Text("House no"),
                          //          // Text(widget.profile?.address[0].houseName),
                          //         ],
                          //       ),
                          //       TableRow(
                          //         children: [
                          //           Text("Street"),
                          //          // Text(widget.profile?.address[0].streetName),
                          //         ],
                          //       ),
                          //     ]),
                        )
                        // new ListTile(
                        //   title: Text("House no : AP45"),
                        // ),
                        // new ListTile(
                        //   title: Text("Street : MH 23"),
                        // ),
                      ],
                    ),
                  ),
            ],
          ),
          state: StepState.complete,
          isActive: currentStep >= 0),
      new Step(
          title: new Text(""),
          content: new Column(
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Text("Professional Details",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.indigo)),
                  )),
              new Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: new ExpansionTile(
                    title: new Text("Job Details"),
                    leading: CircleAvatar(
                      child: Icon(Icons.backup),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: new Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, bottom: 20),
                        child: Table(
                              defaultColumnWidth: const FlexColumnWidth(1.0),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.top,
                              // columnWidths: {1:FractionColumnWidth(10)},
                              children: [
                                TableRow(
                                  children: [
                                    Text("Designation",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.designationName == null ? " " :widget.profile?.designationName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                  TableRow(
                                  children: [
                                    Text("Registration no",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(widget.profile?.regnumber == null ? " " :widget.profile?.regnumber,
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),])
                        
                      )
                      
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              new Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: new ExpansionTile(
                    title: new Text("Hospital Address"),
                    leading: CircleAvatar(
                      child: Icon(Icons.location_on),
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: new Divider(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30, bottom: 20),
                      child: Table(
                              defaultColumnWidth: const FlexColumnWidth(1.0),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.top,
                              // columnWidths: {1:FractionColumnWidth(10)},
                              children: [
                                TableRow(
                                  children: [
                                    Text("Hospital Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(" ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),])
                        
                      )
                    ],
                  )),
            ],
          ),
          // You can change the style of the step icon i.e number, editing, etc.
          state: StepState.complete,
          isActive: currentStep >= 1),
      new Step(
        title: new Text(""),
        content: new Column(
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text("Declaration",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.indigo)),
                )),
            new Container(
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: new ExpansionTile(
                  title: new Text("Payment Details",style:TextStyle(fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black),),
                  leading: CircleAvatar(
                    child: Text("₹"),
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: new Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, bottom: 10),
                      child: Table(
                              defaultColumnWidth: const FlexColumnWidth(1.0),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.top,
                              // columnWidths: {1:FractionColumnWidth(10)},
                              children: [
                                TableRow(
                                  children: [
                                    Text("Payment Mode",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(" ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                 TableRow(
                                  children: [
                                    Text("Registration Fee",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(" ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                                 TableRow(
                                  children: [
                                    Text("Total Amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal)),
                                    Text(" ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),])           
                    )
                  ],
                )),
          ],
        ),
        isActive: currentStep >= 2,
        state: StepState.complete,
      ),
    ];
    return msteps;
  }

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
                    title: Text(
                  'Member Approval',
                  style: TextStyle(
                      color: Colors.black,                   
                      fontSize: 20,),
                )),
              ),
            ];
          },
          body: Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: FractionalOffset.topCenter,
                    child: new Stepper(
                      controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) {
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              currentStep > 0 ? SizedBox(
                                width: MediaQuery.of(context).size.width * .4,                              
                                  child:CircleAvatar(
                                      child: IconButton(
                                    icon: Icon(Icons.keyboard_arrow_left),
                                    onPressed:onStepCancel,
                                    ),
                                      backgroundColor: Colors.lightBlue,
                                      foregroundColor: Colors.white,
                                    )                                                                                              
                              ) :SizedBox( width: 0),
                              SizedBox(width: 10,),
                              currentStep < 2 ? SizedBox(
                                width: MediaQuery.of(context).size.width * .4,                              
                                  child:CircleAvatar(
                                      child: IconButton(
                                    icon: Icon(Icons.keyboard_arrow_right),
                                    onPressed:onStepContinue,
                                    ),
                                      backgroundColor: Colors.lightBlue,
                                      foregroundColor: Colors.white,
                                    )                                                                                              
                              ) :SizedBox( width: 0),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * .4,
                              //   height: 40,
                              //   child: Container(
                              //     child: FlatButton(
                              //         color: Colors.indigo,
                              //         child: Text('>>',
                              //             style: TextStyle(
                              //                 fontWeight: FontWeight.normal,
                              //                 fontSize: 15,
                              //                 color: Colors.white)),
                              //         onPressed: onStepContinue),
                              //         decoration: new BoxDecoration(
                              //          borderRadius: BorderRadius.all(
                              //          Radius.circular(20),                                 
                              //         ),
                              //   ),
                              // ))
                            ],
                          ),
                        );
                      },
                      currentStep: this.currentStep,
                      steps: _memberApprovals(),
                      type: StepperType.horizontal,
                      onStepTapped: (step) {
                        setState(() {
                          currentStep = step;
                          if (step == 2) {
                            isAction = true;
                          }
                        });
                      },
                      onStepCancel: () {
                        setState(() {
                          if (currentStep > 0) {
                            currentStep = currentStep - 1;
                          } else {
                            currentStep = 0;
                          }
                        });
                      },
                      onStepContinue: () {
                        setState(() {
                          if (currentStep < _memberApprovals().length - 1) {
                            currentStep = currentStep + 1;
                          } else {
                            currentStep = 2;
                          }
                          if (currentStep == 2) {
                            isAction = true;
                          } else {
                            isAction = false;
                          }
                        });
                        // Log function call
                        //print("onStepContinue : " + current_step.toString());
                      },
                    ),
                  ),
                  isAction
                      ? Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                height: 40,
                                child: FlatButton.icon(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  color: Colors.orangeAccent,
                                  label: Text('REJECT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.black)),
                                  onPressed: () {
                                    // Perform some action
                                  },
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .5,
                                height: 40,
                                child: Container(
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          left: new BorderSide(
                                              width: 1.0,
                                              color: Colors.black12))),
                                  child: FlatButton.icon(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    color: Colors.teal,
                                    label: Text('APPROVE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                            color: Colors.black)),
                                    onPressed: () {
                                      // Perform some action
                                    },
                                  ),
                                ),
                              )
                            ],
                          ))
                      : new Container()
                ],
              ))),
      // bottomNavigationBar: Stack(
      //   children: <Widget>[],
      // ),
    );
  }
}
