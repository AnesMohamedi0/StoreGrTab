import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';

import 'package:provider/provider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Home/adSpace.dart';
import 'package:grtabstore/ui/widgets/Home/displayProducts.dart';
import 'package:grtabstore/ui/widgets/Home/filters.dart';
import 'package:grtabstore/ui/widgets/Home/flexibleSpaceBar.dart';
import 'package:grtabstore/ui/widgets/Shared/menuButton.dart';

class MobileHomeScreen extends StatelessWidget {
  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              leading: MenuButton(),
              backgroundColor: electricBlueDarkest,
              shadowColor: Colors.black54,
              elevation: 24.0,
              expandedHeight: height * 0.55,
              collapsedHeight: height * 0.08,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double collapseRatio =
                      (constraints.maxHeight - kToolbarHeight) /
                      (height * 0.55 - kToolbarHeight);
                  return CustomFlexibleSpaceContent(
                    collapseRatio: collapseRatio,
                  );
                },
              ),
            ),

            SliverToBoxAdapter(
              child: Adspace(
                height: height * 0.3,
                ad: Ad(
                  id: '1',
                  title: 'Sample Ad',
                  imageUrl:
                      'https://tse4.mm.bing.net/th/id/OIP.mEUH82pqJxMY7ds4egrwCAHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
                  link: 'https://facebook.com',
                ),
              ),
            ),

            SliverToBoxAdapter(child: FiltersSpace(height: height * 0.12)),

            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.01,
              ),
              sliver:
                  context.watch<ProductsProvider>().filteredProducts.isNotEmpty
                  ? SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: height * 0.015,
                        crossAxisSpacing: height * 0.015,
                        childAspectRatio: (width * 0.4) / (height * 0.3),
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = context
                              .watch<ProductsProvider>()
                              .filteredProducts[index];
                          return ProductDisplay(
                            product: product,
                            width: width * 0.4,
                            height: height * 0.3,
                          );
                        },
                        childCount: context
                            .watch<ProductsProvider>()
                            .filteredProducts
                            .length,
                      ),
                    )
                  : Container(
                      height: height * 0.3,
                      alignment: Alignment.center,
                      child: AbelText(
                        text: 'No products found with the applied filters.',
                        fontSize: width * 0.05,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
