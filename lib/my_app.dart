import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xmas_challenge/ui/pages/home_page.dart';
import 'package:xmas_challenge/ui/providers/content_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContentProvider(),
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => HomePage() 
        },
      ),
    );
  }
}