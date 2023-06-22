import 'package:app_restaurant/Widgets/AppBar1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';

class Order extends StatefulWidget {
  final String? commandName;
  final int? tableNumber;
  final List<String> selectedItems;
  final List<int> itemQuantities;

  Order({
    required this.commandName,
    required this.tableNumber,
    required this.selectedItems,
    required this.itemQuantities,
  });

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  DateTime currentDate = DateTime.now();
  String formattedDate =
      DateFormat('dd MMMM yyyy HH:mm').format(DateTime.now());
  final List<int> filteredList = [];
  DatabaseReference dbref =
      FirebaseDatabase.instance.reference().child('orders');
  late DatabaseReference newOrderRef = dbref.push();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    for (var number in widget.itemQuantities) {
      if (number != 0) {
        filteredList.add(number);
      }
    }
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: ListView(
        children: [
          AppBar1(),
          SizedBox(
            height: size.height / 100,
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              "  The Order  ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: size.height / 35,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              height: size.height / 1.5,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "RestaurantName",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "-----------------------------------",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            "Command Name:  ${widget.commandName}",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Table Number:     ${widget.tableNumber}",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "-----------------------------------",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: size.width / 5,
                                  ),
                                  Text(
                                    "Items",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width / 10,
                                  ),
                                  Text(
                                    "Qte",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              for (int i = 0;
                                  i < widget.selectedItems.length;
                                  i++)
                                Row(
                                  children: [
                                    SizedBox(
                                      width: size.width / 5,
                                    ),
                                    Text(
                                      "${widget.selectedItems[i]}",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: size.width / 7,
                                    ),
                                    Text(
                                      "${filteredList[i]}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Date of Command: $formattedDate",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment(300 / size.width, 10),
            child: IconButton(
                icon: Icon(Icons.send_rounded),
                iconSize: 45,
                color: Colors.red.shade400,
                onPressed: () {
                  List<String> selectedItems = widget.selectedItems.toList();
                  List<int> itemQuantities = filteredList.toList();

                  Map<String, dynamic> orders = {
                    'Date of Command': formattedDate,
                    'commandName': widget.commandName.toString(),
                    'tableNumber': widget.tableNumber.toString(),
                    'selectedItems': selectedItems,
                    'itemQuantities': itemQuantities,
                  };

                  dbref
                      .push()
                      .set(orders)
                      .then((value) => {Navigator.of(context).pop()});
                }),
          ),
        ],
      ),
    );
  }
}
