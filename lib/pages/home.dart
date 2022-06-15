import 'package:aoc/general/globals.dart';
import 'package:flutter/material.dart';
// Widgets
import 'package:aoc/widgets/themeWidget.dart';
// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return SafeArea(
      child: Scaffold(
          //backgroundColor: themeProv.bgColor,
          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeProv.grStart,
            themeProv.grEnd,
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                )),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      ThemeSelector(),
                      SizedBox(width: 60),
                      Text(
                        'Home',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 30),
                  // Container(
                  //   width: 360,
                  //   height: 35,
                  //   decoration: const BoxDecoration(
                  //       color: Colors.white,
                  //       // border: Border.all(
                  //       //   color: Colors.black,
                  //       // ),
                  //       borderRadius: BorderRadius.all(Radius.circular(15))),
                  //   child: Row(
                  //     children: [
                  //       IconButton(
                  //         padding: const EdgeInsets.all(1),
                  //         onPressed: () {
                  //           showSearch(
                  //               context: context,
                  //               delegate: CustomSearchDelegate());
                  //         },
                  //         icon: const Icon(Icons.search),
                  //       ),
                  //       const Text('Search'),
                  //     ],
                  //   ),
                  // ),

                  // HomeCard(
                  //     cardTitle: 'Calendar',
                  //     imgSource: 'assets/calendarImg${themeProv.color}.jpg',
                  //     route: '/calendar'),
                  // const SizedBox(height: 20),

                  HomeCard(
                      cardTitle: 'Profile',
                      icon: Icons.person,
                      route: '/myprofile'),
                  HomeCard(
                    cardTitle: 'Explore',
                    icon: Icons.explore,
                    route: '/explore',
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

// WIDGETS

// ignore: must_be_immutable
class HomeCard extends StatelessWidget {
  late String cardTitle;
  late String route;
  late IconData icon;
  HomeCard(
      {Key? key,
      required this.cardTitle,
      required this.icon,
      required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
            color: themeProv.homecard,
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      icon,
                      size: 120,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    cardTitle,
                    style: const TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

// class CustomSearchDelegate extends SearchDelegate {
//   // Demo list
//   List<String> searchTerms = [
//     "Apple",
//     "Banana",
//     "Mango",
//     "Pear",
//     "Watermelons",
//     "Blueberries",
//     "Pineapples",
//     "Strawberries"
//   ];

//   // first overwrite to
//   // clear the search text
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: () {
//           query = '';
//         },
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   // second overwrite to pop out of search menu
//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   // third overwrite to show query result
//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var item in searchTerms) {
//       if (item.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(item);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }

//   // last overwrite to show the
//   // querying process at the runtime
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var item in searchTerms) {
//       if (item.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(item);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return ListTile(
//           title: Text(result),
//         );
//       },
//     );
//   }
// }
