import 'package:clima_exito/domain/entities/weather.dart';
import 'package:flutter/material.dart';

class IconsDescription extends StatelessWidget {
  const IconsDescription({
    super.key, 
    required this.weatherData,
  });

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> weatherDetails = [
      {'icon': Icons.air, 'value': '${weatherData.windSpeed} m/s'},
      {'icon': Icons.cloud, 'value': '${weatherData.clouds} %'},
      {
        'icon': Icons.water_drop_outlined,
        'value': '${weatherData.humidity} %'
      }
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: weatherDetails.map((detail) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Icon(
                detail['icon'],
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              detail['value'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        );
      }).toList(),
    );
  }
}
