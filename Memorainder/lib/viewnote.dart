import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/reminder.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  String des;

  var data;
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllertitle = new TextEditingController();

  @override
  void initState() {
    title = "${widget.data['title']}";
    des = "${widget.data['description']}";
    controllerName.text=des;
    // controllerName.value= controllerName.value.copyWith(text: "${widget.data['description']}",
   // controllerName.selection= TextSelection.fromPosition(TextPosition(offset: des.length));
    controllertitle.text = title;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
       // FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading:  FlatButton(
              onPressed: () {
                update();
              //  Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios_outlined,
                size: 24.0,
              ),
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all(
              //     Colors.grey[700],
              //   ),
              //   padding: MaterialStateProperty.all(
              //     EdgeInsets.symmetric(
              //       horizontal: 25.0,
              //       vertical: 8.0,
              //     ),
              //   ),
              // ),
            ),
            actions: [
              PopupMenuButton(itemBuilder: (context)=>[
                PopupMenuItem(
                  child:  FlatButton(
                    onPressed: delete,
                    child: Text("Delete   ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: "lato",
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // style: ButtonStyle(
                    //   backgroundColor: MaterialStateProperty.all(
                    //     Colors.grey[700],
                    //   ),
                    //   padding: MaterialStateProperty.all(
                    //     EdgeInsets.symmetric(
                    //       horizontal: 25.0,
                    //       vertical: 8.0,
                    //     ),
                    //   ),
                    // ),
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: FlatButton(
                    onPressed: () {
                      update();
                      print(data);
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
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //     MaterialStateProperty.all(Colors.grey[700]),
                    //     padding:
                    //     MaterialStateProperty.all(EdgeInsets.symmetric(
                    //       horizontal: 25.0,
                    //       vertical: 8.0,
                    //     ))),
                  ),
                  value: 2,
                ),
                PopupMenuItem(
                  child: FlatButton(
                   textColor: Colors.white,

                    child: Text(
                      "Remainder",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              Reminder(widget.data, widget.time, widget.ref),
                        ),
                      );
                    },
                  ),
                  value: 3,
                ),
              ],


                // onSelected: (val){
                //   setState(() {
                //
                //   });
                // },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(
                12.0,
              ),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: Icon(
                  //         Icons.arrow_back_ios_outlined,
                  //         size: 24.0,
                  //       ),
                  //       style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all(
                  //           Colors.grey[700],
                  //         ),
                  //         padding: MaterialStateProperty.all(
                  //           EdgeInsets.symmetric(
                  //             horizontal: 25.0,
                  //             vertical: 8.0,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         update();
                  //         print(data);
                  //       },
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
                  //           backgroundColor:
                  //               MaterialStateProperty.all(Colors.grey[700]),
                  //           padding:
                  //               MaterialStateProperty.all(EdgeInsets.symmetric(
                  //             horizontal: 25.0,
                  //             vertical: 8.0,
                  //           ))),
                  //     ),
                  //     //
                  //     ElevatedButton(
                  //       onPressed: delete,
                  //       child: Icon(
                  //         Icons.delete_forever,
                  //         size: 24.0,
                  //       ),
                  //       style: ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all(
                  //           Colors.grey[700],
                  //         ),
                  //         padding: MaterialStateProperty.all(
                  //           EdgeInsets.symmetric(
                  //             horizontal: 25.0,
                  //             vertical: 8.0,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //
                  SizedBox(
                    height: 12.0,
                  ),
                  //
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditableText(
                        controller: new TextEditingController.fromValue(new TextEditingValue(text: title,selection: new TextSelection.collapsed(offset: title.length))),
                        style: TextStyle(
                          fontSize: 32.0,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),

                        onChanged: (_val) {
                          title = _val;
                        },
                        // selectionControls: TextSelectionControls.fromPosition(TextPosition(offset: controller.text.length));,
                        maxLines: null,
                        autofocus: false,
                        focusNode: FocusNode(),
                        cursorColor: Colors.indigoAccent,
                        backgroundCursorColor: Colors.red,


                      ),
                      //
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 12.0,
                        ),
                        child: Text(
                          widget.time,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      //

                      Container(
                        height: MediaQuery.of(context).size.height * 0.615,
                        alignment: Alignment.topLeft,
                        child: EditableText(
                         controller: controllerName,
                         // controller: new TextEditingController.fromValue(new TextEditingValue(text: controllerName.text,selection: new TextSelection.collapsed(offset: controllerName.text.length))),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "lato",
                            color: Colors.grey,
                          ),
                          maxLines: 80,
                          autofocus: false,
                        //textInputAction: TextInputAction.next,
                          focusNode: FocusNode(

                          ),
                          cursorColor: Colors.indigoAccent,
                          backgroundCursorColor: Colors.red,
                          onChanged: (_val) {
                           // selection:TextSelection.collapsed(offset: controllerName.text.length);
                         // selection:  TextSelection.fromPosition(TextPosition(offset: controllerName.text.length));
                            des = _val;
                          },

                        ),
                      ),
                    ],
                  ),
                  // Card(
                  //   color: Colors.black,
                  //
                  //   // margin: EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                  //     child: RaisedButton(
                  //       textColor: Colors.white70,
                  //       color: Colors.deepOrangeAccent,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Text(
                  //             "Set Remainder",
                  //             style: TextStyle(
                  //               fontSize: 20.0,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 5.0,
                  //           ),
                  //           Icon(Icons.access_alarms_rounded),
                  //         ],
                  //       ),
                  //       onPressed: () {
                  //         Navigator.of(context).pushReplacement(
                  //           MaterialPageRoute(
                  //             builder: (context) =>
                  //                 Reminder(widget.data, widget.time, widget.ref),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void update() async {
    // save to db
    //  CollectionReference ref = FirebaseFirestore.instance
    //      .collection('users')
    //      .doc(FirebaseAuth.instance.currentUser.uid)
    //      .collection('notes');

    data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };
    //  widget.ref.collection('users').doc(FirebaseAuth.instance.currentUser.uid).collection('notes').doc(FirebaseAuth.instance.currentUser.uid).update(data);
    //  ref.add(data);
    widget.ref.update(data);

    //

    Navigator.pop(context);
  }

  void delete() async {
    // delete from db
    // await widget.ref.delete();
    await widget.ref.delete();
    Navigator.pop(context);
     Navigator.pop(context);
  }
  @override
  void dispose() {
    controllerName.dispose();
    controllertitle.dispose();
    super.dispose();
  }

}

