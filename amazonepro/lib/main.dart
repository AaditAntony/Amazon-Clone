import 'package:amazonepro/firebase_options.dart';
import 'package:amazonepro/layout/screen_layout.dart';
import 'package:amazonepro/model/product_model.dart';
import 'package:amazonepro/providers/user_details_provider.dart';
import 'package:amazonepro/screen/Sign_in_screen.dart';
import 'package:amazonepro/screen/product_screen.dart';
import 'package:amazonepro/screen/result_screen.dart';
import 'package:amazonepro/screen/sell_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Utils/colortheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const AmazoneClone());
}

class AmazoneClone extends StatelessWidget {
  const AmazoneClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
          title: "AmazoneClone",
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light()
              .copyWith(scaffoldBackgroundColor: backgroundColor),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
                // return const SellScreen();
              } else {
                return const SignInScreen();
              }
            },
          )),
    );
  }
}
// flutter run -d chrome --web-renderer=html  