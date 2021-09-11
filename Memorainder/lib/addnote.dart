import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/reminder.dart';
class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
String title="";
String des="";
CollectionReference ref;
String time;
var data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading:  FlatButton(
            onPressed: () {
              if( title=="" && des==""){
                Navigator.pop(context);
              }
              else {
                add();
              }

              // Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 24.0,
            ),
          ),
          actions: [
            PopupMenuButton(itemBuilder: (context)=>[
              PopupMenuItem(
                child: FlatButton(
                  onPressed: () {
                      title = title == null ? "" : title;
                      des = des == null ? "" : des;
                      add();
                      print(data);
                      Navigator.pop(context);
                      FocusScope.of(context).unfocus();


                  },
                  child: Text(
                    "Save     ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "lato",
                      // fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                value: 2,
              ),
             ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                  //  Row(
                  //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     ElevatedButton(onPressed: (){
                  //       Navigator.of(context).pop();
                  //     },
                  //         child: Icon(
                  //             Icons.arrow_back_ios_outlined,
                  //         size: 24.0,),
                  //
                  //       style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
                  //           padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  //             horizontal: 25.0,
                  //             vertical: 8.0,
                  //           )
                  //           )
                  //       ),
                  //     ),
                  //     ElevatedButton(onPressed: (){
                  //       add();
                  //       FocusScope.of(context).unfocus();
                  //     },
                  //       child: Text(
                  //         "Save",
                  //         style: TextStyle(
                  //           fontSize: 18.0,
                  //           fontFamily: "lato",
                  //           // fontWeight: FontWeight.bold,
                  //           color: Colors.white,
                  //         ),
                  //       ),
                  //       style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all(Colors.grey[700]),
                  //         padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  //           horizontal: 25.0,
                  //           vertical: 8.0,
                  //         )
                  //         )
                  //       ),
                  //     )
                  //   ],
                  // ),
                SizedBox(
                  height: 12.0,
                ),

                Form(child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration.collapsed(
                          hintText: "TITLE"
                      ),
                      style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                      onChanged: (_val){
                        title=_val;
                      },
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          decoration: InputDecoration.collapsed(
                              hintText: "Note Description"
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "lato",
                            // fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                          onChanged: (_val){
                            des=_val;
                          },
                          maxLines: 200,
                        ),

                    )

                  ],
                ))

              ],
            ),
          ),
        ),
      ),
    );
  }
void add() async {
  // save to db
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');

  data = {
    'title': title,
    'description': des,
    'created': DateTime.now(),
  };
  DateTime mydateTime=data['created'];
  time=
  DateFormat.yMMMd().add_jm().format(mydateTime);
  ref..doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes').orderBy('created').snapshots();
  ref.add(data);
  Navigator.pop(context);
  // Navigator.pop(context);
}

}
