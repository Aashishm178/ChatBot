import 'package:chatbot/Utiils/Networking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String userId;
  String email;
  FirebaseUser user;
  ChatScreen({this.userId, this.email, this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  TextEditingController controller;
  Firestore _firestore = Firestore.instance;
  Networking networking = Networking();
  BuildContext _dismissible;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    _dismissible = context;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.email}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Active Now',
              style: TextStyle(color: Colors.blue, fontSize: 15.0),
            ),
          ],
        ),
        backgroundColor: Colors.white70,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: StreamBuilder(
                  stream: _firestore
                      .collection('users')
                      .document(widget.user.uid)
                      .collection('Chats')
                      .document('${widget.user.uid}${widget.userId}')
                      .collection('${widget.user.email}${widget.email}')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemBuilder: (context, index) {
                          DateTime date = DateTime.parse(
                              snapshot.data.documents[index]['time']);
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: snapshot.data.documents[index]
                                        ['UserEmail'] ==
                                    widget.user.email
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Container(
                                    margin: EdgeInsets.all(5.0),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: snapshot
                                                      .data.documents[index]
                                                  ['UserEmail'] ==
                                              widget.user.email
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0),
                                            )
                                          : BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0),
                                              topRight: Radius.circular(20.0),
                                            ),
                                      color: Colors.white,
                                    ),
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width -
                                              50,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(snapshot.data
                                              .documents[index]['message']),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Text(
                                                '${date.hour}:${date.second}'),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          );
                        },
                        itemCount: snapshot.data.documents.length,
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
                  }),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type your message',
                        fillColor: Colors.white70,
                      ),
                      autofocus: false,
                      controller: controller,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (controller.text != null &&
                        controller.text.trim() != '') {
                      try {
                        showDialog(
                            barrierDismissible: false,
                            context: _dismissible,
                            builder: (_) {
                              return AlertDialog(
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircularProgressIndicator(),
                                    Container(
                                      margin: EdgeInsets.only(left: 40.0),
                                      child: Text(
                                        'Sending Message',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                        await networking.sendMessage(
                          widget.user.uid,
                          widget.user.email,
                          widget.userId,
                          widget.email,
                          controller.text.trim(),
                        );
                        Navigator.of(_dismissible).pop();
                        controller.clear();
                      } catch (error) {
                        Navigator.of(_dismissible).pop();
                        print(error);
                      }
                    }
                  },
                  icon: Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
