import 'package:amazonepro/Utils/colortheme.dart';
import 'package:amazonepro/Utils/utils.dart';
import 'package:amazonepro/model/product_model.dart';
import 'package:amazonepro/resources/cloudFirestore_methods.dart';
import 'package:amazonepro/screen/product_screen.dart';
import 'package:amazonepro/widget/custom_simple_rounded_button.dart';
import 'package:amazonepro/widget/product_information.dart';
import 'package:amazonepro/widget/custom_square_button.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;

  const CartItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        height: screenSize.height / 2,
        width: screenSize.width,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
        child: Column(children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductScreen(productModel: product)),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(product.url),
                      ),
                    ),
                  ),
                  ProductInformationWidget(
                      ProductName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName)
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Row(
              children: [
                CustomSquareButton(
                    child: Icon(Icons.remove),
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40),
                CustomSquareButton(
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.cyan),
                    ),
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40),
                CustomSquareButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      await CloudFirestoreClass().addProductToCart(
                          productModel: ProductModel(
                              url: product.url,
                              productName: product.productName,
                              cost: product.cost,
                              discount: product.discount,
                              uid: Utils().getUid(),
                              sellerName: product.sellerName,
                              sellerUid: product.sellerUid,
                              rating: product.rating,
                              noOfRating: product.noOfRating));
                    },
                    color: backgroundColor,
                    dimension: 40),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                          onPressed: () {
                            CloudFirestoreClass()
                                .deleteProductFromCart(uid: product.uid);
                          },
                          text: 'Delete'),
                      SizedBox(
                        width: 5,
                      ),
                      CustomSimpleRoundedButton(
                          onPressed: () {}, text: 'Save for later'),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See more like this",
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ),
                  )
                ],
              ),
            ),
            flex: 1,
          )
        ]),
      ),
    );
  }
}
