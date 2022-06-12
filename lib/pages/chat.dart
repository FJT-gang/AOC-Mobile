import 'package:flutter/material.dart';
import 'package:aoc/general/globals.dart';
// Firebase
import 'package:firebase_auth/firebase_auth.dart';
// Provider
import 'package:provider/otherUserIdprovider.dart';
import 'package:provider/provider.dart';
import '../providers/fireprov.dart';

class Chat extends StatelessWidget {
  late String otherUserId;
  Chat({Key? key, required this.otherUserId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List>(
        create: (context) => FireProv().getMessages(otherUserId),
        initialData: const [],
        child: ChatPage(
          otherUsrId: otherUserId,
        ));
  }
}

class ChatPage extends StatefulWidget {
  late String otherUsrId;
  ChatPage({Key? key, required this.otherUsrId}) : super(key: key);

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

    void setMessages() {
      for (var message in messageData) {
        userMessages.add(
          const SizedBox(height: 50),
        );
        userMessages.add(Message(text: message['message']));
      }
      setState(() {});
    }

    void getMessages() {
      for (var e in messageStream) {
        Map dataMap = Map<dynamic, dynamic>.from(e.data());
        List key = dataMap.keys.toList();
        messageData.add(dataMap[key[0]]);
      }
      setMessages();
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.pexels.com/photos/2853507/pexels-photo-2853507.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      const Text(
                        'Name',
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
  Message({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
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
