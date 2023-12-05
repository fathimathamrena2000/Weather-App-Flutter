import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weather_app/forecastapi.dart';
import 'package:weather_app/model/forecast_weather_model.dart';
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

  DateTime? unpackDate(dynamic k) {
    int millis = k * 1000;
    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  String formatDate(dynamic date) {
    String formattedDate = DateFormat('E').format(date);
    return formattedDate;
  }

  String formatDate2(dynamic date) {
    String formattedDate = DateFormat('hh:mm').format(date);
    return formattedDate;
  }

  String formatDay(dynamic date) {
    String formattedDay = DateFormat('d').format(date);
    return formattedDay;
  }

  int convertToFahrenheit(double fahrenheit) {
    return ((fahrenheit - 32) * 5 / 9).round();
  }

  @override
  Widget build(BuildContext context) {
    final weatherinfo = Provider.of<WeatherDetails>(context);
    final forecastinfo = Provider.of<ForecastDetails>(context, listen: true);
    // final daynames = getNextFiveDays();

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 100, 78, 159),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 100, 78, 159),
        ),
        body: Column(children: [
          const Text(
            "5-Days",
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
                      Row(
                        children: [
                          const Text(
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
                                  "${convertToFahrenheit(forecastinfo.forecastdata!.list[0].main.temp)}\u2103",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 70,
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
              )),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 300,
              child: forecastinfo.forecastdata == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<ForecastDetails>(builder: (context, data, child) {
                      DateTime currentDate = DateTime.now();

                      List<ListElement> forecastData = data.forecastdata!.list;

                      List<ListElement> currentDayForecast = forecastData
                          .where((forecast) =>
                              forecast.dtTxt.year == currentDate.year &&
                              forecast.dtTxt.month == currentDate.month &&
                              forecast.dtTxt.day == currentDate.day)
                          .toList();
                      Map<String, List<ListElement>> groupForecastByDay(
                          List<ListElement> forecastData) {
                        Map<String, List<ListElement>> groupedData = {};

                        for (var element in forecastData) {
                          String date =
                              "${element.dtTxt.year}-${element.dtTxt.month}-${element.dtTxt.day}";

                          if (!groupedData.containsKey(date)) {
                            groupedData[date] = [];
                          }

                          groupedData[date]!.add(element);
                        }

                        return groupedData;
                      }

                      Map<String, List<ListElement>> groupedData =
                          groupForecastByDay(forecastData);

                      return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            String date = groupedData.keys.elementAt(index);
                            List<ListElement> dailyData = groupedData[date]!;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 40,
                                // width: 80,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatDate(unpackDate(dailyData[index].dt)
                                          as DateTime)
                                      // daynames[index],
                                      ,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Image.network(
                                      "https://openweathermap.org/img/wn/${dailyData[index].weather[0].icon}@2x.png",
                                      height: 80,
                                      // width: 100,
                                    ),
                                    Text(dailyData[index].weather[0].main,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w200)),
                                    Text(
                                        "+${dailyData[index].main.tempMin.toString()}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                        "+${dailyData[index].main.tempMax.toString()}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            );
                          });
                    }))
        ]));
  }
}
