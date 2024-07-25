import 'package:intl/intl.dart';
import 'package:vhack_client/model/weather_entity.dart';

import '../../features/crop/domain/entity/crop_entity.dart';

class ConvertDate {
  static convertToDate({required CropEntity cropEntity}) {
    String dateString = '2024-01-16T01:41:03.840797';
    DateTime dateTime = cropEntity.cropDate!;
    String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
    return formattedDate;
  }

  static convertToHour({required CropEntity cropEntity}) {
    String dateString = '2024-01-16T01:41:03.840797';
    DateTime dateTime = cropEntity.cropDate!;
    String formattedDate = DateFormat('HH:mm').format(dateTime);
    return formattedDate;
  }

  static convertToDateWeather({required WeatherEntity weatherEntity}) {
    String dateString = weatherEntity.weatherTime!;
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('E').format(dateTime);
    return formattedDate.toUpperCase();
  }

  static String convertDateString(String dateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(dateString);

    // Get the day, month, and year from the parsed DateTime object
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year % 100; // Get the last two digits of the year

    // Define a list of month names
    List<String> months = [
      'Jan',
      'Feb',
      'Mac',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    // Format the date string
    String formattedDate = '$day ${months[month - 1]} $year';

    return formattedDate;
  }

  static String convertDateHourString(String dateString) {
    final dateTime = DateTime.parse(dateString);
    final formattedDate = DateFormat('dd MMM yy, hh:mm a').format(dateTime);
    return formattedDate;
  }
}
