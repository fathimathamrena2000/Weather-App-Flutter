import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weather_app/weatherapi.dart';

class Days extends StatefulWidget {
  const Days({
    super.key,
  });

  @override
  State<Days> createState() => _DaysState();
}

class _DaysState extends State<Days> {
  DateTime timeZoneToTime(dynamic timezoneOffsetSeconds) {
    // Timezone offset from OpenWeatherMap API (in seconds)

    // Create a Duration with the given offset
    Duration offsetDuration = Duration(seconds: timezoneOffsetSeconds);

    // Get the current UTC time
    DateTime utcTime = DateTime.now().toUtc();

    // Apply the offset to get the local time
    DateTime localTime = utcTime.add(offsetDuration);
    return localTime;
  }

  String formatDate2(dynamic date) {
    String formattedDate = DateFormat('hh:mm').format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final weatherinfo = Provider.of<WeatherDetails>(context);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 100, 78, 159),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 100, 78, 159),
        ),
        body: Column(children: [
          const Text(
            "7-Days",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 380,
                width: 400,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 24, 92),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 197, 142, 206),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Tomorrow\nMostly Cloudy",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 60.0),
                                child: Text(
                                  "19\u00B0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Column(
                                children: [
                                  Icon(
                                    QWeatherIcons
                                        .tag_cloudy_night_fill.iconData,
                                    color: Colors.white70,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      "${weatherinfo.weatherdata!.wind.gust}\u00B0\nGust",
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Column(
                                children: [
                                  Icon(
                                    QWeatherIcons.tag_low_humidity2.iconData,
                                    color: Colors.white70,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      "${weatherinfo.weatherdata!.main.humidity}\u00B0\nHumidity",
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Column(
                                children: [
                                  Icon(
                                    QWeatherIcons.tag_wind.iconData,
                                    color: Colors.white70,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                      "${weatherinfo.weatherdata!.wind.speed}\u00B0\nWind Speed",
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

//
// );
              )),
          const SizedBox(
            height: 5,
          ),
          Column(
            children: [
              Container(
                  height: 20,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Monday",
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w200),
                    //     ),
                    //     Icon(
                    //       Icons.ac_unit,
                    //       color: Colors.white,
                    //     ),
                    //     Text("windy",
                    //         style: TextStyle(
                    //             color: Colors.white24,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w200)),
                    //     Text("high",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w600)),
                    //     Text("low",
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.w600))
                    //   ],
                    // ),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tuesday",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        Icon(
                          Icons.ac_unit,
                        ),
                        Text("windy",
                            style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text("high",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Text("low",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Wednesday",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        Icon(
                          Icons.ac_unit,
                        ),
                        Text("windy",
                            style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text("high",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Text("low",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Thursday",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        Icon(
                          Icons.ac_unit,
                        ),
                        Text("windy",
                            style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text("high",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Text("low",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Friday",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        Icon(
                          Icons.ac_unit,
                        ),
                        Text("windy",
                            style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text("high",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Text("low",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Saturday",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        Icon(
                          Icons.ac_unit,
                        ),
                        Text("windy",
                            style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text("high",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Text("low",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 100, 78, 159),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sunday",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        Icon(
                          Icons.ac_unit,
                        ),
                        Text("windy",
                            style: TextStyle(
                                color: Colors.white24,
                                fontSize: 20,
                                fontWeight: FontWeight.w200)),
                        Text("high",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        Text("low",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  )),
            ],
          ),
        ]));
  }
}
