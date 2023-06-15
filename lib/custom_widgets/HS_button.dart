import 'package:flutter/material.dart';

class HS_button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double padding;

  const HS_button({required this.text, required this.onPressed, this.padding = 50.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            color: Color(0xFFFABE2C),
            borderRadius: BorderRadius.circular(16.83),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}