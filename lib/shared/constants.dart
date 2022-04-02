//used for color schemes and decorations
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    )),
    focusedBorder: OutlineInputBorder(
        //when clicked
        borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    )));

Positioned log = Positioned.fill(
  child: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          Color(0xFF0D47A1),
          Color(0xFF1976D2),
          Color(0xFF42A5F5),
        ],
      ),
    ),
  ),
);
