import 'package:chatbot/Utiils/Networking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FriendRequestScreen extends StatefulWidget {
  FirebaseUser firebaseUser;
  FriendRequestScreen({this.firebaseUser});
  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  Firestore _firestore = Firestore.instance;
  Networking networking = Networking();
  BuildContext _dismissible;

  @override
  void didChangeDependencies() {
    _dismissible = context;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 4,
                width: double.infinity,
                child: Text(
                  'Friend Request\'s',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
              ),
              Positioned(
                left: 10.0,
                top: 40.0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30.0),
                ),
              ),
            ],
          ),
          StreamBuilder(
              stream: _firestore
                  .collection('users')
                  .document(widget.firebaseUser.uid)
                  .collection('FriendRequest')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          var time = DateTime.parse(
                              snapshot.data.documents[index]['Time']);
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  minRadius: 15,
                                  maxRadius: 25,
                                  child: Text(
                                    '${snapshot.data.documents[index]['UserEmail'].toString().toUpperCase()[0]}',
                                  ),
                                ),
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${snapshot.data.documents[index]['UserEmail'].toString()}',
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.done),
                                          onPressed: () async {
                                            try {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: _dismissible,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircularProgressIndicator(),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 40.0),
                                                            child: Text(
                                                              'Adding Friend',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                              await networking
                                                  .acceptFriendRequest(
                                                widget.firebaseUser.uid,
                                                widget.firebaseUser.email,
                                                snapshot.data.documents[index]
                                                    ['UserId'],
                                                snapshot.data.documents[index]
                                                    ['UserEmail'],
                                                snapshot.data.documents[index]
                                                    .documentID,
                                              );
                                              Navigator.of(_dismissible).pop();
                                            } catch (error) {
                                              Navigator.of(_dismissible).pop();
                                              print(error);
                                            }
                                          },
                                          color: Colors.blueAccent,
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.clear),
                                          onPressed: () async {
                                            try {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: _dismissible,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CircularProgressIndicator(),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 40.0),
                                                            child: Text(
                                                              'Deleting Request',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                              await networking.deleteRequest(
                                                  widget.firebaseUser.uid,
                                                  snapshot.data.documents[index]
                                                      .documentID);
                                              Navigator.of(_dismissible).pop();
                                            } catch (error) {
                                              Navigator.of(_dismissible).pop();
                                              print(error);
                                            }
                                          },
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                    'REQUEST SENT ON ${time.day}/${time.month}/${time.year} at ${time.hour}:${time.minute}'),
                              ),
                            ),
                          );
                        }),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return Container();
                }
              })
        ],
      ),
    );
  }
}
