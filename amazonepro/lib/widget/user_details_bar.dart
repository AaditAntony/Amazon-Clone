import 'package:amazonepro/Utils/colortheme.dart';
import 'package:amazonepro/Utils/constants.dart';
import 'package:amazonepro/model/user_details_model.dart';
import 'package:amazonepro/providers/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;

  const UserDetailsBar({
    super.key,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetails =
        Provider.of<UserDetailsProvider>(context).userDetails;
    Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: -offset / 5,
      child: Container(
        height: kAppBarHeight / 2,
        width: screenSize.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: lightBackgroundaGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.7,
                child: Text(
                  "Deliver to ${userDetails.name} - ${userDetails.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[900]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
