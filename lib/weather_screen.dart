import 'dart:convert';
import 'dart:ui';

import 'package:basic_weather_app/additional_information_items.dart';
import 'package:basic_weather_app/hourly_forcast_card.dart';
import 'package:basic_weather_app/secret.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  late Future <Map<String , dynamic>> weather;

  Future <Map<String , dynamic>> getCurrentWeather() async{
    try{
      final res = await http.get(
        Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=Kuala%20Lumpur&APPID=$OpenWeatherAPIKey"),
      );

      final data = jsonDecode(res.body);
      if(data["cod"] != "200"){
        throw "An unexpected error occured";
      }

        //temp = data["list"][0]["main"]["temp"];
        //temp = temp - 273.15;
        return data;
     
    }catch(e){
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        actions:  [
          IconButton(
           onPressed: (){
              weather = getCurrentWeather();
           },
          icon: Icon(Icons.refresh))
          
        ],
      ),

      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          double currenttemp = data["list"][0]["main"]["temp"];
          currenttemp -= 273.15;

          final currentsky = data["list"][0]["weather"][0]["main"];
          final currentpressure = data["list"][0]["main"]["pressure"];
          final currenthumidity = data["list"][0]["main"]["humidity"];
          final currentwindspeed = data["list"][0]["wind"]["speed"];
          
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5 , sigmaY: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text('${currenttemp.toStringAsFixed(0)}°' , style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),),
                        
                            const SizedBox(height: 10,),
                            //|| currentsky == "Rain" || currentsky == "Clear"
                            Icon(
                              currentsky == "Clouds" ? Icons.cloud
                              : currentsky == "Rain" ? Icons.water_rounded
                              : Icons.sunny,
                              size: 60,
                            ),
                            const SizedBox(height: 10,),
                            Text("$currentsky", style: TextStyle(
                              fontSize: 20,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 20,),
              //weather forecast
              
              const Text("Hourly Forecast",style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
        
               //SingleChildScrollView(
                //scrollDirection: Axis.horizontal,
                //child: Row(
                  //children: [
                    //for(int i = 1 ; i < 6 ; i++)
                    //ForecastCard(
                      //icon: data["list"][i]["weather"][0]["main"] == "Clouds" ? Icons.cloud
                      //: data["list"][i]["weather"][0]["main"] == "Rain" ? Icons.water_rounded
                      //: Icons.sunny,
                     // label: data["list"][i]["dt"].toString(),
                     // temp: "${(data["list"][i]["main"]["temp"] - 273.15).toStringAsFixed(0)}°",
                   // ),
                 // ],
              //  ),
             // ),

              SizedBox(
                height: 123,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder:(context, index) {
                    final time = DateTime.parse(data["list"][index + 1]["dt_txt"]);
                    return ForecastCard(
                      icon: data["list"][index + 1]["weather"][0]["main"] == "Clouds" ? Icons.cloud
                        : data["list"][index + 1]["weather"][0]["main"] == "Rain" ? Icons.water_rounded
                        : Icons.sunny, 
                      label: DateFormat.j().format(time), 
                      temp: "${(data["list"][index + 1]["main"]["temp"] - 273.15).toStringAsFixed(0)}°"
                    );
                  },
                  ),
              ),
          
              const SizedBox(height: 20,),
                //additional information
              
              const Text("Addtional Information", style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdditionalInformationItems(
                    icon: Icons.water_drop,
                    label: "Humidity" ,
                    value: currenthumidity.toString(),
                  ),
                  AdditionalInformationItems(
                    icon: Icons.air,
                    label: "Wind Speed" ,
                    value: currentwindspeed.toString(),
                  ),
                  AdditionalInformationItems(
                    icon: Icons.beach_access,
                    label: "Pressure" ,
                    value: currentpressure.toString(),
                  ),
        
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }
}



