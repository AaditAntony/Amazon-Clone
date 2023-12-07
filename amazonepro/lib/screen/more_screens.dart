import 'package:amazonepro/Utils/constants.dart';
import 'package:amazonepro/widget/category_widget.dart';
import 'package:amazonepro/widget/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(hasBackButton: false, isReadOnly: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.2 / 3.5,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemCount: categoriesList.length,
              itemBuilder: (context, Index) => CategoryWidget(index: Index)),
        ));
  }
}
