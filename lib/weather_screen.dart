import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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

           },
          icon: Icon(Icons.refresh))
          
        ],
      ),

      body: Padding(
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
                          Text("30°" , style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),),
                      
                          const SizedBox(height: 10,),
                          Icon(Icons.cloud , size: 60,),
                          const SizedBox(height: 10,),
                          Text("Rain", style: TextStyle(
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
            
            const Text("Weather Forecast",style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ForecastCard(),
                  ForecastCard(),
                  ForecastCard(),
                  ForecastCard(),
                  ForecastCard(),
                ],
              ),
            ),
        
            const SizedBox(height: 20,),
              //additional information
            const Placeholder(
              fallbackHeight: 150,
            ),
        
          ],
        ),
      ),
    );
  }
}



class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                    width: 110,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("03:00" , style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),),
                            const SizedBox(height: 10,),
                            Icon(Icons.cloud , size: 30,),
                            const SizedBox(height: 10,),
                            Text("30°" , style: TextStyle(
                              fontSize: 15,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}