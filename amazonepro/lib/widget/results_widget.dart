import 'package:amazonepro/model/product_model.dart';
import 'package:amazonepro/screen/product_screen.dart';
import 'package:amazonepro/widget/cost_widget.dart';
import 'package:amazonepro/widget/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ResultsWidget extends StatelessWidget {
  final ProductModel product;
  const ResultsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(productModel: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screensize.width / 3,
              child: Image.network(product.url),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                product.productName,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  SizedBox(
                      width: screensize.width / 5,
                      child: FittedBox(
                          child: RatingStarWidget(rating: product.rating))),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product.noOfRating.toString(),
                      style: TextStyle(color: Colors.cyan),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: 20,
                child: FittedBox(
                  child: CostWidget(
                      color: Color.fromARGB(255, 92, 9, 3), cost: product.cost),
                ))
          ],
        ),
      ),
    );
  }
}
