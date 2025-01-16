import 'package:atm_machine_app/screen/atm_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AtmApp());
}

class AtmApp extends StatelessWidget {
  const AtmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AtmScreen(),
    );
  }
}
