import 'dart:core';

import 'package:flutter/material.dart';
import 'package:weather_app/weatherapi.dart';

class CurrentData extends StatelessWidget {
  final WeatherDetails weatherInfo;
  final String day;
  final IconData weatherIcon;
  final String description;
  final String hvalue;
  final String lvalue;

  const CurrentData({
    super.key,
    required this.weatherInfo,
    required this.day,
    required this.weatherIcon,
    required this.description,
    required this.hvalue,
    required this.lvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 100, 78, 159),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              day,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w200),
            ),
            Icon(
              weatherIcon,
            ),
            Text(description,
                style: TextStyle(
                    color: Colors.white24,
                    fontSize: 20,
                    fontWeight: FontWeight.w200)),
            Text(hvalue,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            Text(lvalue,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
