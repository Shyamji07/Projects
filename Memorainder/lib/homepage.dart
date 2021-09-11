import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/addnote.dart';
import 'package:notes/viewnote.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');
  bool viewtype;


  List<Color> myColors = [
    Colors.yellow[200],
    Colors.red[200],
    Colors.green[200],
    Colors.deepPurple[200],
    Colors.amber[200],
    Colors.orange[200],
    Colors.lime[200],
    Colors.lightBlueAccent[200],
    Colors.indigoAccent,
    Colors.blue,
    Colors.blue[800],
    Colors.lightGreen,
    Colors.purpleAccent,
    Colors.deepOrangeAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
          .then((value) {
          print("Calling Set  State !");
          setState(() {});
          });
        },

        child: Icon(
          Icons.add,
          color:Colors.white70 ,
        ),
        backgroundColor: Colors.grey[700],

      ),
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
            fontSize: 32.0,
            fontFamily: "lato",
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color(0xff070706),
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(
              child: Text("ListView"),
              value: true,
            ),
            PopupMenuItem(
              child: Text("GridView"),
              value: false,
            ),
          ],

            onSelected: (val){
           setState(() {
             viewtype=val;
           });
            },
          ),
        ],
      ),
      body: viewtype==true?_ListView(ref: ref,mycolors: myColors,):_GridView(ref: ref,mycolors: myColors,),
    );
  }
  @override
  void initState() {
    viewtype=false;
    super.initState();
  }
}
class _GridView extends StatefulWidget {
  const _GridView({ this.ref, this.mycolors}) ;
  final CollectionReference ref;
  final List<Color>mycolors;

  @override
  __GridViewState createState() => __GridViewState();
}

class __GridViewState extends State<_GridView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: widget.ref.get(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5/ 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 0.0,
               // mainAxisExtent:145
              ),

              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                Random random = new Random();
                Color bg =widget.mycolors[random.nextInt(13)];
                Map data=snapshot.data.docs[index].data();
                DateTime mydateTime=data['created'].toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data.docs[index].reference,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8,top: 8,right: 8,bottom:8
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data['title']}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 32.0,
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("${data['description']}",
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            maxLines: 1,


                          ),

                          SizedBox(height: 15,),
                          Container(
                            alignment: Alignment.centerLeft,
                            child:Text(DateFormat.yMMMd().add_jm().format(mydateTime),
                              //mydateTime.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ) ,
                          ),


                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        else{
          return Center(
            child:Text("LOADING...."),
          );
        }

      },


    );
  }
}
class _ListView extends StatefulWidget {
  const _ListView({ this.ref, this.mycolors}) ;
  final CollectionReference ref;
  final List<Color>mycolors;

  @override
  __ListViewState createState() => __ListViewState();
}

class __ListViewState extends State<_ListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: widget.ref.get(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(

              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                Random random = new Random();
                Color bg =widget.mycolors[random.nextInt(13)];
                Map data=snapshot.data.docs[index].data();
                DateTime mydateTime=data['created'].toDate();
                String formattedTime =
                DateFormat.yMMMd().add_jm().format(mydateTime);

                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ViewNote(
                          data,
                          formattedTime,
                          snapshot.data.docs[index].reference,
                        ),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20),
                    ),
                    color: bg,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12,top: 8,right: 12,bottom: 8
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${data['title']}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 32.0,
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                         SizedBox(height: 5,),

                          Text("${data['description']}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: "lato",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child:Text(DateFormat.yMMMd().add_jm().format(mydateTime),
                              //mydateTime.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "lato",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ) ,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        else{
          return Center(
            child:Text("LOADING...."),
          );
        }

      },


    );
  }
}

