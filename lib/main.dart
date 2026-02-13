import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppy/auth_gate.dart';
import 'package:shoppy/providers/auth_provider.dart';
import 'package:shoppy/providers/product_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'my_colors.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://kvkgcvdozajsdxwimdfq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt2a2djdmRvemFqc2R4d2ltZGZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzA5MzcxODAsImV4cCI6MjA4NjUxMzE4MH0.0kIiP_A6GUsw3gpHFs0NQM9LPNUiYWXD-T1D0aRksp0',
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.secondaryColor),
      ),
      home: AuthGate(),
    );
  }
}
