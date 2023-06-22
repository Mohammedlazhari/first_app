import 'package:flutter/material.dart';

class NameCommand extends StatefulWidget {
  @override
  _NameCommand createState() => _NameCommand();
}

class _NameCommand extends State<NameCommand> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 5,
      ),
      child: TextFormField(
        controller: _controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: "Name of Command",
          hintStyle: TextStyle(fontSize: 22),
          border: UnderlineInputBorder(),
        ),
      ),
    );
  }
}
