import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Globals.bgDarkBlue,
        child: Column(
          children: [
            Container(
              color: Globals.bgDarkBlue,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
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
            Container(height: 575, color: Globals.bgLightBlue),
            Container(
                height: 77,
                color: Globals.bgDarkBlue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 300,
                      color: Colors.white,
                      child: Text(
                        'typ here',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
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
