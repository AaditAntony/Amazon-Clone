import 'package:amazonepro/Utils/colortheme.dart';
import 'package:amazonepro/Utils/constants.dart';
import 'package:amazonepro/model/order_request_model.dart';
import 'package:amazonepro/model/product_model.dart';
import 'package:amazonepro/model/user_details_model.dart';
import 'package:amazonepro/providers/user_details_provider.dart';
import 'package:amazonepro/screen/sell_screen.dart';
import 'package:amazonepro/widget/account_screen_appbar.dart';
import 'package:amazonepro/widget/custom_main_button.dart';
import 'package:amazonepro/widget/product_showcase_listview.dart';
import 'package:amazonepro/widget/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<Widget>? yourOrder;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
          child: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Column(
          children: [
            IntroductionWidgetAccountScreen(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMainButton(
                  child: Text(
                    ("Sign Out"),
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.orange,
                  isLoading: false,
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMainButton(
                  child: Text(
                    ("Sell"),
                    style: TextStyle(color: Colors.black),
                  ),
                  color: Colors.yellow,
                  isLoading: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SellScreen()));
                  }),
            ),
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('orders')
                  .get(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  List<Widget> children = [];
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    ProductModel model = ProductModel.getModelFromJson(
                        json: snapshot.data!.docs[i].data());
                    children.add(SimpleProductWidget(productModel: model));
                  }
                  return ProductShowcaseListView(
                      title: 'Your orders', children: children);
                }
              },
            ),
            const Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order Request",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('orderRequests')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              OrderRequestModel model =
                                  OrderRequestModel.getModelFromJson(
                                      json: snapshot.data!.docs[index].data());
                              return ListTile(
                                title: Text(
                                  "Order: ${model.orderName}",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle:
                                    Text("Address:  ${model.buyersAddress}"),
                                trailing: IconButton(
                                    onPressed: () async {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('orderRequests')
                                          .doc(snapshot.data!.docs[index].id)
                                          .delete();
                                    },
                                    icon: Icon(Icons.check)),
                              );
                            });
                      }
                    }))
          ],
        ),
      )),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white.withOpacity(0.000000000001)
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                      )),
                  TextSpan(
                      text: "${userDetailsModel.name}",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRy1Yqg_okA7LHxNuCduFWehr7jKjz4iyjW-w&usqp=CAU"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
