import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Reminder extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

   Reminder( this.data, this.time, this.ref) ;

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  FlutterLocalNotificationsPlugin fltrNotification;
  String _selectedParam;
  String task;
  int val;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('cover');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    new InitializationSettings(android:androidInitilize,iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Sangam", "This is my channel",
        importance: Importance.max,
         priority: Priority.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android:androidDetails,iOS: iSODetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails, payload: "Task");
    var scheduledTime;
    if (_selectedParam == "Hour") {
      scheduledTime = DateTime.now().add(Duration(hours: val));
    } else if (_selectedParam == "Minutes") {
      scheduledTime = DateTime.now().add(Duration(minutes: val));
    }else if(_selectedParam=="Day"){
      scheduledTime=DateTime.now().add(Duration(days: val));
    }else if(_selectedParam=="Year"){
      scheduledTime=DateTime.now().add(Duration(days: (val*365)));
    }else if(_selectedParam=="Month"){
      scheduledTime=DateTime.now().add(Duration(days: val*30));
    }
    else {
      scheduledTime = DateTime.now().add(Duration(seconds: val));
    }

    fltrNotification.schedule(
        1, "${widget.data['title']}","${widget.data['description']}" , scheduledTime, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),

          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Reminder",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            // textBaseline: TextBaseline.alphabetic,
            // fontStyle: FontStyle.italic
          ),
        ),
      ),

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: TextField(
            //     decoration: InputDecoration(border: OutlineInputBorder()),
            //     onChanged: (_val) {
            //       task = _val;
            //     },
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonTheme(materialTapTargetSize: MaterialTapTargetSize.padded,
                  child: DropdownButton(
                    value: _selectedParam,
                    items: [
                      DropdownMenuItem(
                        child: Text("Seconds"),
                        value: "Seconds",
                      ),
                      DropdownMenuItem(
                        child: Text("Minutes"),
                        value: "Minutes",
                      ),
                      DropdownMenuItem(
                        child: Text("Hour"),
                        value: "Hour",
                      ),
                      DropdownMenuItem(
                        child: Text("Day"),
                        value: "Day",
                      ),
                      DropdownMenuItem(
                        child: Text("Month"),
                        value: "Month",
                      ),
                      DropdownMenuItem(
                        child: Text("Year"),
                        value: "Year",
                      ),
                    ],
                    hint: Text(
                      "Select Your Field.",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (_val) {
                      setState(() {
                        _selectedParam = _val;
                      });
                    },
                  ),
                ),
                ButtonTheme(
                  alignedDropdown: true,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  highlightColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: DropdownButton(

                      value: val,
                        isDense: false,
                        itemHeight: 50.0,

                      items: [
                        DropdownMenuItem(
                          child: Text("1"),
                          value: 1,

                        ),
                        DropdownMenuItem(
                          child: Text("2"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text("3"),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text("4"),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text("5"),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text("6"),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text("7"),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Text("8"),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Text("9"),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Text("10"),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text("11"),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          child: Text("12"),
                          value: 12,
                        ),
                        DropdownMenuItem(
                          child: Text("13"),
                          value: 13,
                        ),
                        DropdownMenuItem(
                          child: Text("14"),
                          value: 14,
                        ),
                        DropdownMenuItem(
                          child: Text("15"),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Text("16"),
                          value: 16,
                        ),
                        DropdownMenuItem(
                          child: Text("17"),
                          value: 17,
                        ),
                        DropdownMenuItem(
                          child: Text("18"),
                          value: 18,
                        ),
                        DropdownMenuItem(
                          child: Text("19"),
                          value: 19,
                        ),
                        DropdownMenuItem(
                          child: Text("20"),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Text("21"),
                          value: 21,
                        ),
                        DropdownMenuItem(
                          child: Text("22"),
                          value: 22,
                        ),
                        DropdownMenuItem(
                          child: Text("23"),
                          value: 23,
                        ),
                        DropdownMenuItem(
                          child: Text("24"),
                          value: 24,
                        ),
                        DropdownMenuItem(
                          child: Text("25"),
                          value: 25,
                        ),
                        DropdownMenuItem(
                          child: Text("26"),
                          value: 26,
                        ),
                        DropdownMenuItem(
                          child: Text("27"),
                          value: 27,
                        ),
                        DropdownMenuItem(
                          child: Text("28"),
                          value: 28,
                        ),
                        DropdownMenuItem(
                          child: Text("29"),
                          value: 29,
                        ),
                        DropdownMenuItem(
                          child: Text("30"),
                          value: 30,
                        ),
                        DropdownMenuItem(
                          child: Text("31"),
                          value: 31,
                        ),
                      ],
                      hint: Text(
                        "Select Value",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (_val) {
                        setState(() {
                          val = _val;

                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100.0,),
            RaisedButton(
              onPressed: (){
                _showNotification();
                Navigator.pop(context);
              },
              child: new Text('Set Task With Notification'),
            )
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    // showDialog(
    //   context: context,
    //   builder: (context) =>
    //       AlertDialog(
    //         content: Text("Notification Clicked ${payload}"),
    //
    //       ),
    // );
    Navigator.pop(context);

  }
  void delete() async {
    // delete from db
    // await widget.ref.delete();
    await widget.ref.delete();
    Navigator.pop(context);
  }
}
