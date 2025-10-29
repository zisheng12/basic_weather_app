
import 'package:flutter/material.dart';

class AdditionalInformationItems extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInformationItems({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(icon , size: 30,),
                      const SizedBox(height: 5,),
                      Text(label),
                      const SizedBox(height: 5,),
                      Text(value , style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),),
                                    
                    ],
                  ),
                );
  }
}