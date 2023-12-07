import 'dart:developer';

import 'package:amazonepro/Utils/utils.dart';
import 'package:amazonepro/resources/authentication_method.dart';
import 'package:amazonepro/screen/Sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Utils/constants.dart';
import '../widget/custom_main_button.dart';
import '../widget/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticatonMethods authenticatonMethods = AuthenticatonMethods();
  bool isLoading = false;
  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    addresscontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  amazonLogo,
                  height: screensize.height * 0.10,
                ),
                SizedBox(
                  height: screensize.height * 0.7,
                  child: FittedBox(
                    child: Container(
                      height: screensize.height * 0.85,
                      width: screensize.width * 0.8,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign-Up",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 33),
                          ),
                          TextFieldWidget(
                            title: "Name",
                            controller: namecontroller,
                            obscureText: false,
                            hintText: "Enter the Name",
                          ),
                          TextFieldWidget(
                            title: "Email",
                            controller: emailcontroller,
                            obscureText: false,
                            hintText: "Enter the Email",
                          ),
                          TextFieldWidget(
                            title: "Address",
                            controller: addresscontroller,
                            obscureText: false,
                            hintText: "Enter the Address",
                          ),
                          TextFieldWidget(
                            title: "Password",
                            controller: passwordcontroller,
                            obscureText: true,
                            hintText: "Enter the Password",
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomMainButton(
                              color: Colors.yellow,
                              isLoading: isLoading,
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                String output =
                                    await authenticatonMethods.signupUser(
                                        name: namecontroller.text,
                                        address: addresscontroller.text,
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text);
                                setState(() {
                                  isLoading = false;
                                });
                                if (output == "success") {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const SignInScreen()));
                                } else {
                                  Utils().showSnackBar(
                                      context: context, content: output);
                                }
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    letterSpacing: 0.6, color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomMainButton(
                    child: const Text(
                      "Back",
                      style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                    ),
                    color: Colors.grey,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
