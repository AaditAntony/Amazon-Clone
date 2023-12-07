import 'package:amazonepro/Utils/colortheme.dart';
import 'package:amazonepro/Utils/constants.dart';
import 'package:amazonepro/Utils/utils.dart';
import 'package:amazonepro/model/product_model.dart';
import 'package:amazonepro/model/review_model.dart';
import 'package:amazonepro/model/user_details_model.dart';
import 'package:amazonepro/providers/user_details_provider.dart';
import 'package:amazonepro/resources/cloudFirestore_methods.dart';
import 'package:amazonepro/widget/cost_widget.dart';
import 'package:amazonepro/widget/custom_main_button.dart';
import 'package:amazonepro/widget/custom_simple_rounded_button.dart';
import 'package:amazonepro/widget/rating_star_widget.dart';
import 'package:amazonepro/widget/review_dialog.dart';
import 'package:amazonepro/widget/review_widget.dart';
import 'package:amazonepro/widget/search_bar_widget.dart';
import 'package:amazonepro/widget/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({super.key, required this.productModel});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Expanded spaceThingy = Expanded(child: Container());
    return SafeArea(
        child: Scaffold(
      appBar: SearchBarWidget(hasBackButton: true, isReadOnly: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height -
                        (kAppBarHeight + (kAppBarHeight / 2)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: kAppBarHeight / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.productModel.sellerName,
                                      style: const TextStyle(
                                          color: Colors.cyan, fontSize: 16),
                                    ),
                                  ),
                                  Text(widget.productModel.productName)
                                ],
                              ),
                              RatingStarWidget(
                                  rating: widget.productModel.rating)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: screenSize.height / 3,
                            constraints: BoxConstraints(
                                maxHeight: screenSize.height / 3),
                            child: Image.network(widget.productModel.url),
                          ),
                        ),
                        spaceThingy,
                        CostWidget(
                            color: Colors.black,
                            cost: widget.productModel.cost),
                        spaceThingy,
                        CustomMainButton(
                            child: Text(
                              "Buy Now",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.orange,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFirestoreClass().addProductToOrders(
                                  model: widget.productModel,
                                  userDetails: Provider.of<UserDetailsProvider>(
                                          context,
                                          listen: false)
                                      .userDetails);
                              Utils().showSnackBar(
                                  context: context, content: 'done');
                            }),
                        spaceThingy,
                        CustomMainButton(
                            child: Text(
                              "Add to cart",
                              style: TextStyle(color: Colors.black),
                            ),
                            color: Colors.yellow,
                            isLoading: false,
                            onPressed: () async {
                              await CloudFirestoreClass().addProductToCart(
                                  productModel: widget.productModel);
                              Utils().showSnackBar(
                                  context: context, content: "Added to cart");
                            }),
                        spaceThingy,
                        CustomSimpleRoundedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => ReviewDialog(
                                        productUid: widget.productModel.uid,
                                      ));
                            },
                            text: "Add a review for this product"),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: screenSize.height,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("products")
                              .doc(widget.productModel.uid)
                              .collection("reviews")
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ReviewModel model =
                                      ReviewModel.getModelFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data());
                                  return ReviewWidget(
                                    review: model,
                                  );
                                },
                              );
                            }
                          }))
                ],
              ),
            ),
          ),
          const UserDetailsBar(offset: 0)
        ],
      ),
    ));
  }
}
