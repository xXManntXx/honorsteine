import 'package:flutter/material.dart';

class HS_button2 extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double padding;

  const HS_button2({required this.text, required this.onPressed, this.padding = 50.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
           
            borderRadius: BorderRadius.circular(16.83),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.amber,
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