import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aoc/general/globals.dart';
// Firebase
// Provider
import 'package:provider/provider.dart';
import '../providers/fireprov.dart';

class Chat extends StatelessWidget {
  late String userName;
  late String otherUserId;
  late String imgSource;
  Chat({Key? key, required this.otherUserId, required this.userName, required this.imgSource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List>(
        create: (context) => FireProv().getMessages(otherUserId),
        initialData: const [],
        child: ChatPage(
          otherUsrId: otherUserId,
          usrName: userName,
          imgSource: imgSource,
        ));
  }
}

class ChatPage extends StatefulWidget {
  late String otherUsrId;
  late String usrName;
  late String imgSource;
  ChatPage(
      {Key? key,
      required this.otherUsrId,
      required this.usrName,
      required this.imgSource})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fireProv = Provider.of<FireProv>(context, listen: true);
    var messageStream = Provider.of<List>(context, listen: true);

    List messageData = [];
    List<Widget> userMessages = [];
    List messageList = [];
    var userId = FirebaseAuth.instance.currentUser!.uid;
    void setMessages() {
      for (var message in messageList) {
        userMessages.add(
          const SizedBox(height: 50),
        );
        userMessages.add(Message(
          text: message['message'],
          fromUsr: message['sender'] == userId,
        ));
      }
      setState(() {});
    }

    List myTestList = [];

    void orderMessages() {
      for (var e in messageData) {
        String firstE = e.keys.elementAt(0);
        myTestList.add(firstE);
      }
      myTestList.sort();
      for (var e in myTestList) {
        for (var m in messageData) {
          if (m.keys.elementAt(0) == e) {
            messageList.add(m[e]);
          }
        }
      }
      setMessages();
    }

    void getMessages() {
      for (var e in messageStream) {
        Map dataMap = Map<dynamic, dynamic>.from(e.data());
        List key = dataMap.keys.toList();
        messageData.add(dataMap);
      }
      // setMessages();
      orderMessages();
    }

    getMessages();

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            color: Globals.bgDarkBlue,
            child: Column(
              children: [
                Container(
                  color: Globals.bgDarkBlue,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // go back button
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(widget.imgSource), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Text(
                        widget.usrName,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Container(
                    height: 515,
                    width: 10000,
                    color: Globals.bgLightBlue,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: userMessages,
                    )),
                Container(
                    height: 77,
                    color: Globals.bgDarkBlue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 300,
                            height: 20,
                            color: Colors.grey[100],
                            child: TextFormField(
                              controller: messageController,
                            )),
                        IconButton(
                            onPressed: () {
                              fireProv.sendMessages(
                                  widget.otherUsrId, messageController.text);
                              setState(() {});
                              messageController.text = "";
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            )),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

class Message extends StatelessWidget {
  late String text;
  late bool fromUsr;
  Message({required this.text, required this.fromUsr, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? msgColor = fromUsr ? Colors.blue[900] : Colors.blue[200];
    return Container(
      color: msgColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            )),
      ),
    );
  }
}
