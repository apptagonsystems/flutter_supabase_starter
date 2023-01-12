import 'package:all_in_one/models/UserModel.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  final UserModel userModel;
  const AccountScreen({super.key, required this.userModel});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
