import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aoc/general/globals.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
// Firebase
// Provider
import 'package:provider/provider.dart';
import '../providers/fireprov.dart';

import '../services/imgserv.dart';

import '../providers/themeprov.dart';


class Chat extends StatelessWidget {
  late String userName;
  late String otherUserId;
  late String imgSource;
  Chat(
      {Key? key,
      required this.otherUserId,
      required this.userName,
      required this.imgSource})
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
     var themeProv = Provider.of<ThemeProv>(context, listen: true);

    ImgServ imgServ = ImgServ();


    List messageData = [];
    List<Widget> userMessages = [const SizedBox(height: 50)];
    List messageList = [];
    var userId = FirebaseAuth.instance.currentUser!.uid;
    void setMessages() {
      for (var message in messageList) {
        userMessages.add(Message(
          text: message['message'],
          fromUsr: message['sender'] == userId,
          type: message['type'],
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

    var pickedImage;
    Future pickImage() async {
      try {
        pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        pickedImage;
        if (pickedImage == null) {
          return;
        } else {
          var date = DateTime.now();
          String imgUrl = await imgServ.pushImageMessage(
              'users/$userId/chat/$date', pickedImage!);

          if (imgUrl != "") {
            fireProv.sendMessages(widget.otherUsrId, imgUrl, 'image');
          }
        }
      } on PlatformException catch (e) {
        print('Failed to get image: $e');
      }
    }

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            color: themeProv.bgColor,
            child: Stack(
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
                                image: NetworkImage(widget.imgSource),
                                fit: BoxFit.cover),
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
                      children: [
                        IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: const Icon(Icons.photo, color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              fireProv.sendMessages(widget.otherUsrId,
                                  messageController.text, 'text');
                              setState(() {});
                              messageController.text = "";
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
                                  image: NetworkImage(widget.imgSource),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Text(
                          widget.usrName,
                          style: const TextStyle(
                              fontSize: 25, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                // middenste stuk met berichten
                Align(
                  child: Container(
                      height: 585,
                      width: 1000,
                      color: themeProv.bgColor,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: userMessages,
                      )),
                ),

                // text container
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 100,
                      color: themeProv.homecard,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 300,
                              height: 30,
                              color: Colors.white,
                              child: TextFormField(
                                controller: messageController,
                                decoration: InputDecoration(
                                  hintText: 'Typ your message',
                                ),
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
                                size: 30,
                              )),
                        ],
                      )),
                )
              ],
            ),
          )),
    );
  }
}

class Message extends StatelessWidget {
  late String text;
  late bool fromUsr;
  late String type;
  Message(
      {required this.text, required this.fromUsr, required this.type, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget message = const Text('');
    if (type == 'text') {
      message = SizedBox(
        // width: 200,

        child: Text(text,
            textAlign: TextAlign.end,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
      );
    } else if (type == 'image') {
      message = Image.network(
        text,
        height: 200,
        width: 200,
      );
    }
    Color? msgColor = fromUsr ? Colors.blue[900] : Colors.blue[200];

    return Container(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: fromUsr ? Alignment.topRight : Alignment.topLeft,
        child: Container( 
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
              color: msgColor,
          ),
           child: message
          ),
      ),
    );
  }
}
