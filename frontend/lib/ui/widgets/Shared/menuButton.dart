import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(Icons.menu),
      color: Colors.white,
      iconSize: width * 0.08,
      padding: EdgeInsets.zero,
    );
  }
}
