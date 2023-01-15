import 'package:flutter/material.dart';

class WeatherMeasurementWidget extends StatelessWidget {
  final IconData icon;
  final String measurement;
  final int valueMeasurement;
  final bool isShouldBeBig;
  const WeatherMeasurementWidget(
      {super.key,
      required this.icon,
      required this.measurement,
      required this.valueMeasurement,
      this.isShouldBeBig = false});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: isShouldBeBig ? size.width / 2 : (size.width - 45) / 4,
      child: Column(
        children: [
          Icon(
            icon,
            size: isShouldBeBig ? 50 : 30,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "$valueMeasurement $measurement",
            style: TextStyle(fontSize: isShouldBeBig ? 20 : 15),
          )
        ],
      ),
    );
  }
}
