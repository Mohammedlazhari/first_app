import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/AppBar1.dart';
import '../Widgets/Oreder_liste.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          //App Bar

          AppBar1(),

          // search
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.search,
                      color: Colors.red.shade900,
                    ),
                    Container(
                      height: 50,
                      width: 287,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            hintText: "What woud you like to eat ??",
                            hintStyle: TextStyle(fontSize: 18),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //OrderList.
          OrderList(),
        ],
      ),
    );
  }
}
