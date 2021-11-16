import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaHistoryWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('MA HISTORY DIRIA')]),
          ),
        ),
      ),
    );
  }
}
