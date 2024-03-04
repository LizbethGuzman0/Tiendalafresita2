import 'package:flutter/material.dart';


import 'package:hive_flutter/hive_flutter.dart';
import 'package:tiendalafresita/home.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('productos');

  await Hive.openBox('categorias');

  await Hive.openBox('ventas');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFdb7090)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
