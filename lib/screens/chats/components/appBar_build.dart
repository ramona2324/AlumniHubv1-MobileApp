import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text('Chats'),
    centerTitle: true,
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
    ],
    toolbarHeight: 56.0,
  );
}
