import 'package:flutter/material.dart';
import 'package:grtabstore/providers/AdminProvider/orderPanelProvider.dart';
import 'package:grtabstore/ui/theme/colors.dart';
import 'package:grtabstore/ui/widgets/Admin/OrderPanel/orderPanelCard.dart';
import 'package:grtabstore/ui/widgets/Shared/animatedFlexibleSpace.dart';
import 'package:grtabstore/ui/widgets/Shared/footer.dart';
import 'package:grtabstore/ui/widgets/Shared/logoDisplay.dart';
import 'package:grtabstore/ui/widgets/Shared/text.dart';
import 'package:provider/provider.dart';

class MobileOrderPanelPage extends StatefulWidget {
  const MobileOrderPanelPage({super.key});

  @override
  State<MobileOrderPanelPage> createState() => _MobileOrderPanelPageState();
}

class _MobileOrderPanelPageState extends State<MobileOrderPanelPage> {
  @override
  void initState() {
    super.initState();
    // Fetch orders when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderPanelProvider>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: primaryBackground,
      appBar: AppBar(
        toolbarHeight: height * 0.175,
        backgroundColor: Colors.transparent,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textOnDark, size: width * 0.07),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Stack(
          children: [
            Positioned(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AnimatedFlexibleSpace(placeOrder: true),
              ),
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoDisplay(size: width * 0.15, padding: false),
                    SizedBox(height: height * 0.008),
                    TitlesText(
                      text: 'Order Panel',
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: textOnDark,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: height * 0.7,
            padding: EdgeInsets.all(width * 0.03),
            child: Consumer<OrderPanelProvider>(
              builder: (context, orderPanelProvider, child) {
                if (orderPanelProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (orderPanelProvider.orders.isEmpty) {
                  return Center(
                    child: Text(
                      'No orders found',
                      style: TextStyle(fontSize: width * 0.05),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: orderPanelProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = orderPanelProvider.orders[index];
                    return OrderPanelCard(order: order);
                  },
                );
              },
            ),
          ),
          WebsiteFooter(),
        ],
      ),
    );
  }
}
