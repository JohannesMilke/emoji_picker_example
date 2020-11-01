import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String message;

  const MessageWidget({
    @required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12);
    final borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius:
                borderRadius.subtract(BorderRadius.only(bottomRight: radius)),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
