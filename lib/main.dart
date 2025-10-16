import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/auth_gate.dart';
import 'package:shoppy/providers/auth_provider.dart';
import 'package:shoppy/providers/product_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'my_colors.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qsprnnneosjkwpgtghxl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzcHJubm5lb3Nqa3dwZ3RnaHhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg5NzY4NzgsImV4cCI6MjA3NDU1Mjg3OH0.kEtH6cLb6WGwdpO47QxX2JDKha77kArQ9UEZk4QYS5c',
  );
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.secondaryColor),
      ),
      home: AuthGate(),
    );
  }
}
