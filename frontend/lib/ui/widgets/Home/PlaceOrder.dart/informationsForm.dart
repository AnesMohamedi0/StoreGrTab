import 'package:flutter/material.dart';
import 'package:grtabstore/ui/widgets/Home/PlaceOrder.dart/textForm.dart';

class InformationsForm extends StatelessWidget {
  const InformationsForm({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        TextForm(
          controller: TextEditingController(),
          label: 'name',
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
