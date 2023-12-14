import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weather_app/5days.dart';
import 'package:weather_app/forecastapi.dart';
import 'package:weather_app/model/forecast_weather_model.dart';
import 'package:weather_app/weatherapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WeatherDetails>(context, listen: false).fetchData();
    Provider.of<ForecastDetails>(context, listen: false).fetchData();
  }

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

//format date
  String formatDate(dynamic date) {
    String formattedDate = DateFormat('E d, y').format(date);
    return formattedDate;
  }

  String formatDate2(dynamic date) {
    String formattedDate = DateFormat('hh:mm').format(date);
    return formattedDate;
  }

  String formatDateDay(dynamic date) {
    String formattedDate = DateFormat('E').format(date);
    return formattedDate;
  }

  int convertToFahrenheit(double fahrenheit) {
    return ((fahrenheit - 32) * 5 / 9).round();
  }

  @override
  Widget build(BuildContext context) {
    final weatherinfo = Provider.of<WeatherDetails>(context, listen: true);
    final forecastinfo = Provider.of<ForecastDetails>(context, listen: true);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 100, 78, 159),
      // appBar: AppBar(),
      body: weatherinfo.weatherdata == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Column(
                children: [
                  Text(
                    forecastinfo.forecastdata!.city.country,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    weatherinfo.weatherdata!.weather[0].description.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "${convertToFahrenheit(weatherinfo.weatherdata!.main.temp)}\u2103",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 180,
                    child: Lottie.asset(
                      'assets/Cloud.json',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${formatDate2(timeZoneToTime(weatherinfo.weatherdata!.timezone))}  AM | ${formatDate(unpackDate(weatherinfo.weatherdata!.dt))} ",
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 180,
                    width: 370,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 43, 24, 92),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 197, 142, 206),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  QWeatherIcons.tag_cloudy_night_fill.iconData,
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
                            padding: const EdgeInsets.all(8.0),
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
                            padding: const EdgeInsets.all(8.0),
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
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Today",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Days(),
                              ));
                            },
                            child: const Text(
                              "5-Day Forecasts",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 160,
                              child: forecastinfo.forecastdata == null
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Consumer<ForecastDetails>(
                                      builder: (context, data, child) {
                                      DateTime currentDate = DateTime.now();

                                      List<ListElement> forecastData =
                                          data.forecastdata!.list;

                                      List<ListElement> currentDayForecast =
                                          forecastData
                                              .where((forecast) =>
                                                  forecast.dtTxt.year ==
                                                      currentDate.year &&
                                                  forecast.dtTxt.month ==
                                                      currentDate.month &&
                                                  forecast.dtTxt.day ==
                                                      currentDate.day)
                                              .toList();

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: currentDayForecast.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 150,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 43, 24, 92),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 197, 142, 206),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    // ${currentDayForecast[index].dt}
                                                    formatDate2(
                                                        currentDayForecast[
                                                                index]
                                                            .dtTxt),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Image.network(
                                                    "https://openweathermap.org/img/wn/${currentDayForecast[index].weather[0].icon}@2x.png",
                                                    height: 80,
                                                    width: 80,
                                                  ),
                                                  Text(
                                                    "${convertToFahrenheit(currentDayForecast[index].main.temp)} \u00B0C",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }))),
                    ],
                  ),
                ],
              ),
            )),
    );
  }
}
