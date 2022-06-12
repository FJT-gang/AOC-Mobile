import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';
// Provider
import 'package:provider/provider.dart';
// Pages
import 'package:aoc/pages/otherprofile.dart';

// ignore: must_be_immutable
class ProfLink extends StatelessWidget {
  late String logoSource;
  late String usrPath;
  ProfLink({required this.logoSource, required this.usrPath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fireStream = Provider.of<List>(context, listen: true);
    String usrName = "";

    String userId = usrPath.substring(6);
    for (var e in fireStream) {
      if (userId == e.data().keys.toList().first) {
        usrName = e.data()[userId]['name'];
        break;
        // setState(() {});
      }
      // print(e.data()[fireProv.userId!.uid].toString());
    }
    print('id: $userId');
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => OtherProfile(userId: userId),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: 350,
            child: Card(
              color: Globals.bgDarkBlue,
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    //const SizedBox(width: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 30, 15),
                      child: Image.network(
                        logoSource,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    //const SizedBox(width: 50),
                    Text(
                      usrName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
