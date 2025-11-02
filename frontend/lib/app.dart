import 'package:flutter/material.dart';
import 'package:grtabstore/ui/screens/Home/desktopHome_screen.dart';
import 'package:grtabstore/ui/screens/Home/mobileHome_screen.dart';
import 'package:grtabstore/ui/widgets/responsiveLayout.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrTabStore',
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobile: MobileHomeScreen(),
        desktop: DesktopHomeScreen(),
      ),
    );
  }
}
