import 'package:flutter/material.dart';
import 'package:grtabstore/ui/screens/Home/desktopHome_screen.dart';
import 'package:grtabstore/ui/screens/Home/mobileHome_screen.dart';
import 'package:grtabstore/ui/widgets/Shared/responsiveLayout.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrTabStore',
      initialRoute: '/',
      routes: {
        '/': (context) => ResponsiveLayout(
          mobile: MobileHomeScreen(),
          desktop: DesktopHomeScreen(),
        ),
        '/home': (context) => ResponsiveLayout(
          mobile: MobileHomeScreen(),
          desktop: DesktopHomeScreen(),
        ),
      },
      // Handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
            mobile: MobileHomeScreen(),
            desktop: DesktopHomeScreen(),
          ),
        );
      },
    );
  }
}
