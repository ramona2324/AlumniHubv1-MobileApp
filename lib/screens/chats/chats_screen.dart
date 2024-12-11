import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/appBar_build.dart';
import '../message/components/body.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: const Body(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: primaryColor,
          child: const Icon(Icons.person_add_alt_1, color: Colors.white),
        ),
      ),
    );
  }
}
