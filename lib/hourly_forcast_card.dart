import 'package:flutter/material.dart';
class ForecastCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String temp;
  const ForecastCard({
    super.key,
    required this.icon,
    required this.label,
    required this.temp,
    });

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
                            Text(label , style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10,),
                            Icon(icon , size: 30,),
                            const SizedBox(height: 10,),
                            Text(temp , style: TextStyle(
                              fontSize: 15,
                            ),),
                          ],
                        ),
                      ),
                    ),
                  );
  }
}