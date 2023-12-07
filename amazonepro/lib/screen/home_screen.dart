import 'package:amazonepro/Utils/constants.dart';
import 'package:amazonepro/model/user_details_model.dart';
import 'package:amazonepro/resources/cloudFirestore_methods.dart';
import 'package:amazonepro/widget/banner_add_widget.dart';
import 'package:amazonepro/widget/catogries_horizontal_list_view_bar.dart';
import 'package:amazonepro/widget/loading_widget%20.dart';
import 'package:amazonepro/widget/product_showcase_listview.dart';
import 'package:amazonepro/widget/search_bar_widget.dart';
import 'package:amazonepro/widget/simple_product_widget.dart';
import 'package:amazonepro/widget/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloudFirestoreClass().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreClass().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductsFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);

    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: false,
        ),
        body: discount70 != null &&
                discount60 != null &&
                discount50 != null &&
                discount0 != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        SizedBox(
                          height: kAppBarHeight / 2,
                        ),
                        CategoriesHorizontalListViewBar(),
                        BannerAdWidget(),
                        ProductShowcaseListView(
                            title: "upto 70% off", children: discount70!),
                        ProductShowcaseListView(
                            title: "upto 60% off", children: discount60!),
                        ProductShowcaseListView(
                            title: "upto 50% off", children: discount50!),
                        ProductShowcaseListView(
                            title: "Explore", children: discount0!),
                      ],
                    ),
                  ),
                  UserDetailsBar(offset: offset),
                ],
              )
            : const LoadingWidget());
  }
}
