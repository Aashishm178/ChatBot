import 'package:chatbot/Screens/FriendRequestScreen.dart';
import 'package:chatbot/Screens/ChatScreen.dart';
import 'package:chatbot/Utiils/Networking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatListScreen extends StatefulWidget {
  FirebaseUser firebaseUser;
  ChatListScreen({this.firebaseUser});
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  Firestore _firestore = Firestore.instance;
  Networking networking = Networking();
  BuildContext _dismissible;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  var bottomSheetScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    _dismissible = context;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('ChatScreen'),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FriendRequestScreen(
                        firebaseUser: widget.firebaseUser,
                      )));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: StreamBuilder(
                        stream: _firestore
                            .collection('users')
                            .document(widget.firebaseUser.uid)
                            .collection('FriendRequest')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data.documents.length > 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        '${snapshot.data.documents.length}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text('0',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0)),
                                    ),
                                  );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('0',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0)),
                              ),
                            );
                          }
                        })),
              ],
            ),
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                    ),
                    context: context,
                    builder: (context) {
                      return DraggableScrollableSheet(
                        maxChildSize: 0.8,
                        expand: false,
                        builder: (context, scrollController) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'FriendName',
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                          controller: searchController,
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                StreamBuilder(
                                  stream: _firestore
                                      .collection('AllUsers')
                                      .where('UserEmail',
                                          isEqualTo: searchController.text)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data.documents.length > 0
                                          ? Expanded(
                                              child: ListView.builder(
                                                padding: EdgeInsets.all(20.0),
                                                itemCount: snapshot
                                                    .data.documents.length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.0),
                                                      child: ListTile(
                                                        trailing: snapshot
                                                                    .data
                                                                    .documents[
                                                                        index]
                                                                    .documentID !=
                                                                widget
                                                                    .firebaseUser
                                                                    .uid
                                                            ? RaisedButton(
                                                                color: Colors
                                                                    .blueAccent,
                                                                onPressed:
                                                                    () async {
                                                                  try {
                                                                    showDialog(
                                                                        context:
                                                                            _dismissible,
                                                                        builder:
                                                                            (_) {
                                                                          return AlertDialog(
                                                                            content:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                CircularProgressIndicator(),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(left: 40.0),
                                                                                  child: Text(
                                                                                    'Sending Request',
                                                                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        });
                                                                    var response = await networking.sendFriendRequest(
                                                                        snapshot.data.documents[index]
                                                                            [
                                                                            'UserId'],
                                                                        widget
                                                                            .firebaseUser
                                                                            .email,
                                                                        widget
                                                                            .firebaseUser
                                                                            .uid);
                                                                    Navigator.of(
                                                                            _dismissible)
                                                                        .pop();
                                                                    if (response[
                                                                            'status'] ==
                                                                        'success') {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      scaffoldKey
                                                                          .currentState
                                                                          .hideCurrentSnackBar();
                                                                      SnackBar snack = SnackBar(
                                                                          action: SnackBarAction(
                                                                              textColor: Colors
                                                                                  .purpleAccent,
                                                                              label:
                                                                                  'OK',
                                                                              onPressed:
                                                                                  () {}),
                                                                          elevation:
                                                                              6.0,
                                                                          behavior: SnackBarBehavior
                                                                              .floating,
                                                                          duration: Duration(
                                                                              seconds:
                                                                                  4),
                                                                          content:
                                                                              Text(response['message']));
                                                                      scaffoldKey
                                                                          .currentState
                                                                          .showSnackBar(
                                                                              snack);
                                                                      searchController
                                                                          .clear();
                                                                    } else if (response[
                                                                            'status'] ==
                                                                        'fail') {
                                                                      scaffoldKey
                                                                          .currentState
                                                                          .hideCurrentSnackBar();
                                                                      SnackBar snack = SnackBar(
                                                                          action: SnackBarAction(
                                                                              textColor: Colors
                                                                                  .purpleAccent,
                                                                              label:
                                                                                  'OK',
                                                                              onPressed:
                                                                                  () {}),
                                                                          elevation:
                                                                              6.0,
                                                                          behavior: SnackBarBehavior
                                                                              .floating,
                                                                          duration: Duration(
                                                                              seconds:
                                                                                  4),
                                                                          content:
                                                                              Text(response['message']));
                                                                      scaffoldKey
                                                                          .currentState
                                                                          .showSnackBar(
                                                                              snack);
                                                                    } else {
                                                                      print(
                                                                          'HIII');
                                                                    }
                                                                  } catch (error) {
                                                                    Navigator.of(
                                                                            _dismissible)
                                                                        .pop();
                                                                    print(
                                                                        error);
                                                                  }
                                                                },
                                                                child: Text(
                                                                  'Add +',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .lightBlueAccent,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0),
                                                                        )),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: Text(
                                                                    'Hey its you',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                        title: Text(
                                                          '${snapshot.data.documents[index]['UserEmail'].toString()}',
                                                        ),
                                                        leading: CircleAvatar(
                                                          minRadius: 15,
                                                          maxRadius: 25,
                                                          child: Text(
                                                            '${snapshot.data.documents[index]['UserEmail'].toString().toUpperCase()[0]}',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                controller: scrollController,
                                              ),
                                            )
                                          : Center(
                                              child: Container(
                                                child: Text(
                                                    'Please write correct name'),
                                              ),
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
                                  },
                                ),
                              ],
                            );
                          });
                        },
                      );
                    });
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('users')
              .document(widget.firebaseUser.uid)
              .collection('FriendList')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        user: widget.firebaseUser,
                                        email: snapshot.data.documents[index]
                                            ['UserEmail'],
                                        userId: snapshot.data.documents[index]
                                            ['UserId'],
                                      )));
                            },
                            title: Text(
                              '${snapshot.data.documents[index]['UserEmail'].toString()}',
                            ),
                            leading: CircleAvatar(
                              minRadius: 15,
                              maxRadius: 25,
                              child: Text(
                                '${snapshot.data.documents[index]['UserEmail'].toString().toUpperCase()[0]}',
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Container();
            }
          }),
    );
  }
}
