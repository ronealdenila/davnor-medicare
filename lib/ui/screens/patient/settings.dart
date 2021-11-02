import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {},
        color: Colors.black,
        ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                logo,
                fit: BoxFit.fill,
                height: 120,
                width: 120,
              ),
            ), 
            verticalSpace10,
             Text('Davnor Medicare',
              style: subtitle18RegularOrange,
            ),
           verticalSpace35,
            Align(
              alignment: Alignment.topLeft,
              child: Text('Settings',
              style: title24Bold,),
            ),
          verticalSpace25,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              horizontalSpace20,
              const Icon(Icons.translate_outlined),
              horizontalSpace10,
              InkWell(
                onTap: () {},
                child: const Text(
                  'Change Language',
                  style: subtitle20Medium,
                ),
              ),
            ]),
          verticalSpace15,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              horizontalSpace25,
              const Icon(Icons.info_outline_rounded),
              horizontalSpace10,
              InkWell(
                onTap: () {},
                child: const Text(
                  'App Info',
                  style: subtitle20Medium,
                ),
              ),
          ]),
        ]),
      ),
    );
  }
} 