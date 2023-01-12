import 'package:all_in_one/models/UserModel.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final UserModel userModel;
  const MainScreen({super.key, required this.userModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
