import 'package:flutter/material.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Shared/menuButton.dart';
import 'package:grtabstore/ui/widgets/Home/AnimatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: MenuButton(),
              backgroundColor: electricBlue,
              expandedHeight: height * 0.4,
              collapsedHeight: height * 0.08,
              flexibleSpace: FlexibleSpaceBar(
                title: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitlesText(
                        text: "Graphics Tablet Store",
                        fontSize: width * 0.05,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                background: AnimatedFlexibleSpace(),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(title: Text('Item $index'));
              }, childCount: 20),
            ),
          ],
        ),
      ),
    );
  }
}
