import 'package:amazonepro/Utils/colortheme.dart';
import 'package:amazonepro/widget/cost_widget.dart';
import 'package:flutter/material.dart';

import '../Utils/colortheme.dart';

class ProductInformationWidget extends StatelessWidget {
  final String ProductName;
  final double cost;

  final String sellerName;
  const ProductInformationWidget(
      {super.key,
      required this.ProductName,
      required this.cost,
      required this.sellerName});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    SizedBox spaceThingy = const SizedBox(
      height: 7,
    );

    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              ProductName,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: 0.9,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: CostWidget(
                color: Colors.black,
                cost: cost,
              ),
            ),
          ),
          spaceThingy,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Sold by ",
                  style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              TextSpan(
                  text: sellerName,
                  style: TextStyle(color: Colors.cyan, fontSize: 14))
            ])),
          )
        ],
      ),
    );
  }
}
