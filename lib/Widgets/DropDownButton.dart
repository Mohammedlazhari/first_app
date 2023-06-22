import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  _DropDownButtonState() {
    selectedval = itemsList[0];
  }
  // variables

  final itemsList = [
    "001",
    "002",
    "003",
    "004",
    "005",
    "006",
    "007",
    "008",
    "009",
    "010",
    "011",
    "012",
    "013",
    "014",
    "015",
    "016",
    "017",
    "018"
  ];
  String selectedval = "";
  String newValue = "";
  @override
  Widget build(BuildContext context) {
    // size of screen
    // final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: 5, left: 10),
      child: Container(
       
        
        child: DropdownButtonFormField(
          value: selectedval,
          items: itemsList
              .map((e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ))
              .toList(),
          onChanged: (val) {
            setState(() {
              selectedval = val.toString();
            });
          },
          style: TextStyle(color: Colors.black, fontSize: 20),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
          dropdownColor: Colors.blue.shade50,
          decoration: InputDecoration(
              labelText: "Table",
              labelStyle: TextStyle(fontSize: 18),
              prefixIcon: Icon(
                Icons.table_restaurant_rounded,
                color: Colors.blueAccent,
              )),

          // underline: Container(),
        ),
      ),
    );
  }
}
