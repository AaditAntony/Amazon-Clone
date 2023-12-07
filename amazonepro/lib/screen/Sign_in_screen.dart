import 'dart:js_util';

import 'package:amazonepro/Utils/utils.dart';
import 'package:amazonepro/resources/authentication_method.dart';
import 'package:amazonepro/screen/Sign_up_screen.dart';
import 'package:amazonepro/widget/custom_main_button.dart';
import 'package:amazonepro/widget/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../Utils/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticatonMethods authenticatonMethods = AuthenticatonMethods();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
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
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: screensize.height * 0.5,
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
                          "Sign-in",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 33),
                        ),
                        TextFieldWidget(
                          title: "Email",
                          controller: emailcontroller,
                          obscureText: false,
                          hintText: "Enter the Email",
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
                              Future.delayed(Duration(seconds: 1));
                              String output =
                                  await authenticatonMethods.signInUser(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                              setState(() {
                                isLoading = false;
                              });
                              if (output == "success") {
                                //function
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "New to Amazone?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomMainButton(
                    child: const Text(
                      "Create an Amazone Account",
                      style: TextStyle(letterSpacing: 0.6, color: Colors.black),
                    ),
                    color: Colors.grey,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
