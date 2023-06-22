import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../pages/Order.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<int> itemsList = List.filled(18, 0);

  int? selectedTable;
  late List<bool> isCheckedList = List.filled(18, false);
  final List<String> selectedItems = [];
  List<int> itemQuantities = List.filled(18, 0);

  final TextEditingController _controller = TextEditingController();
  List<TextEditingController> quantityControllers =
      List.generate(18, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 18; i++) {
      itemsList[i - 1] = i;
    }
  }

  void resetPage() {
    setState(() {
      selectedTable = null;
      _controller.clear();
      isCheckedList = List.generate(18, (index) => false);
      itemQuantities = List.generate(18, (index) => 0);
      selectedItems.clear();

      // Reset the quantity text field values
      for (int i = 0; i < quantityControllers.length; i++) {
        quantityControllers[i].text = '';
      }
    });
  }

  void handleCheckout() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Order(
            commandName: _controller.text,
            selectedItems: selectedItems,
            tableNumber: selectedTable,
            itemQuantities: itemQuantities,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 10),
                    child: Container(
                      child: DropdownButtonFormField<int>(
                        value: selectedTable,
                        items: itemsList
                            .map(
                              (e) => DropdownMenuItem<int>(
                                child: Text(e.toString()),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedTable = val;
                          });
                        },
                        onSaved: (val) {
                          selectedTable = val;
                        },
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueAccent,
                        ),
                        dropdownColor: Colors.blue.shade50,
                        decoration: InputDecoration(
                          labelText: "Table",
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(
                            Icons.table_restaurant_rounded,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 5),
                    child: TextFormField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Name Order",
                        hintStyle: TextStyle(fontSize: 22),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Order List ",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: size.height / 1.9,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(18, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Container(
                      width: size.width - 50,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 48,
                              child: Checkbox(
                                value: isCheckedList[index],
                                activeColor: Colors.red.shade400,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isCheckedList[index] = value ?? false;
                                    if (value!) {
                                      selectedItems.add(
                                          "A_${(index + 1).toString().padLeft(2, '0')}");
                                    } else {
                                      selectedItems.remove(
                                          "A_${(index + 1).toString().padLeft(2, '0')}");
                                      itemQuantities[index] = 0;
                                      quantityControllers[index].text = '';
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "A_${(index + 1).toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("/\\/"),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                                left: 80,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue.shade50,
                                ),
                                child: SizedBox(
                                  width: 50,
                                  child: TextFormField(
                                    controller: quantityControllers[index],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      hintText:
                                          isCheckedList[index] ? null : '0',
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        if (isCheckedList[index]) {
                                          itemQuantities[index] =
                                              int.tryParse(value) ?? 0;
                                        } else
                                          itemQuantities[index] = 0;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(children: [
            SizedBox(width: 30),
            IconButton(
                icon: Icon(Icons.restore_outlined),
                iconSize: 40,
                color: Colors.red.shade400,
                onPressed: resetPage),
            SizedBox(width: size.width / 1.9),
            IconButton(
              icon: Icon(Icons.shopping_cart_checkout_sharp),
              iconSize: 45,
              color: Colors.red.shade400,
              onPressed: handleCheckout,
            ),
          ]),
        ],
      ),
    );
  }
}
