import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/custom_widgets/HS_button.dart';

class CustomInfoWindow extends InfoWindow {
  final String title;
  final String snippet;
  final String photo;
  final String buttonText;
  final Function onPressed;

  CustomInfoWindow({
    required this.title,
    required this.snippet,
    required this.photo,
    required this.buttonText,
    required this.onPressed,
  }) : super(title: title, snippet: snippet);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 200.0,
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          Text(snippet),
          Image.network(photo),
          HS_button(
            onPressed: onPressed,
            text: (buttonText),
          ),
        ],
      ),
    );
  }
}
