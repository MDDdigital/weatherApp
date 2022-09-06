import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:weathapp/model/weather_model.dart';
import 'package:weathapp/service/weather_api_client.dart';
import 'package:weathapp/views/additional_information.dart';
import 'views/current_weath.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'XIBARU DIWU DJI'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // how let's test it everything work

  // we will call the api in the init state function
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  // now everything work
  //but we will use the better method to call the api via the
  // FutureBuider Widget
  Future<void> getData() async {
    // let's try a changing the city name
    data = await client.getCurrentWeather("Dakar");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(widget.title),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
            color: Colors.black,
          ),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                //here we will display if we get data from the Api
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    currentWeather(Icons.wb_sunny_rounded, "${data!.temp}",
                        "${data!.cityname}"),
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      "Additional Information",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Color(0xdd212121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 20.0,
                    ),
                    additionalInformation("${data!.wind}", "${data!.humidity}",
                        "${data!.pressure}", "${data!.feels_like}"),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            }
            // This trailing comma makes auto-formatting nicer for build methods.
            ));
  }
}
