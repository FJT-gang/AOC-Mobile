import 'package:flutter/material.dart';

// Provider
import 'package:provider/provider.dart';
import 'package:aoc/providers/themeprov.dart';

class ThemeSelector extends StatefulWidget {
  const ThemeSelector({Key? key}) : super(key: key);

  @override
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector> {
  @override
  Widget build(BuildContext context) {
    var themeProv = Provider.of<ThemeProv>(context, listen: true);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Color(0xFF000000)),
          left: BorderSide(width: 1.0, color: Color(0xFF000000)),
          right: BorderSide(width: 1.0, color: Color(0xFF000000)),
          bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PopupMenuButton(
          color: themeProv.bgColor,
          elevation: 0,
          onSelected: (value) {
            Provider.of<ThemeProv>(context, listen: false).changeTheme(value);
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Wrap(
              
              children: const [
                Text(
                  'Themas',
                  style: TextStyle(
                  color: Colors.black,
                ),
              ),
                Icon(
                  Icons.arrow_downward_rounded,
                  size: 17.0,
                  )
              ],
            ),
          ),
          
          itemBuilder: (context) => [
            const PopupMenuItem(
                value: 'blue',
                child: Center(
                  child: Text(
                    'Blauw',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
            const PopupMenuItem(
                value: 'orange',
                child: Center(
                  child: Text(
                    'Oranje',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
