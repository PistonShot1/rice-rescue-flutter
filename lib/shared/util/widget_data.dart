import 'package:flutter/material.dart';
import 'package:vhack_client/presentation/components/chart/line_chart.dart';

import '../../presentation/components/chart/custom_slider.dart';

class WidgetData {
  static List listMetric = [
    {
      'metricID': '1',
      'metricTitle': 'Nutrients',
      'metricWidget': const CustomSlider(
        percentage: 50.00,
        lineWidth: 10,
        radius: 100,
      ),
      'metricDesc': '1st Phase Deficiency'
    },
    {
      'metricID': '2',
      'metricTitle': 'Fertilization Phase',
      'metricWidget': const CustomSlider(
        percentage: 50.00,
        lineWidth: 10,
        radius: 100,
      ),
      'metricDesc': '7 Days'
    },
    {
      'metricID': '3',
      'metricTitle': 'Soil Temperature',
      'metricWidget': LineChartSample2(),
      'metricDesc': '27 C'
    },
    {
      'metricID': '4',
      'metricTitle': 'Soil Moisture',
      'metricWidget': LineChartSample2(),
      'metricDesc': '16% at Sungai Petani'
    },
  ];

  static List listFeatures = [
    {
      'featureID': '1',
      'featureTitle': 'Analyze Disease',
      'featureIcon': 'assets/Crop Vision.svg'
    },
    {
      'featureID': '2',
      'featureTitle': 'Chat Bot',
      'featureIcon': 'assets/feature/Chatbot icon.svg'
    },
    {
      'featureID': '3',
      'featureTitle': 'Weather',
      'featureIcon': 'assets/feature/weather_feature.svg'
    },
    {
      'featureID': '4',
      'featureTitle': 'Machines',
      'featureIcon': 'assets/feature/Machines icon.svg'
    },
    {
      'featureID': '5',
      'featureTitle': 'Team',
      'featureIcon': 'assets/feature/Team icon.svg'
    },
    {
      'featureID': '6',
      'featureTitle': 'Services',
      'featureIcon': 'assets/feature/Services icon.svg'
    }
  ];
}
