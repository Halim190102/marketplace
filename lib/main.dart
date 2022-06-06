import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marketplace/Provider/buy.dart';
import 'package:marketplace/Provider/profil.dart';
import 'package:marketplace/Provider/shopping_cart.dart';
import 'package:marketplace/Views/Login%20Pages/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ShoppingCart(),
          ),
          ChangeNotifierProvider(
            create: (context) => BuyCart(),
          ),
          ChangeNotifierProvider(
            create: (context) => DataProfil(),
          ),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('id', 'ID'),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Online Shop',
          home: LoginPage(),
        ),
      ),
    );
  }
}
