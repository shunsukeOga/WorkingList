import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraint) {
      return Stack(
        children: <Widget>[
          Container(
            color: const Color.fromRGBO(183, 225, 218, 1),
          ),
        ],
      );
    });
  }
}
