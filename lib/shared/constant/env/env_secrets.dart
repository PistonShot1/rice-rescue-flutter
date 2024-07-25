import 'package:envied/envied.dart';

part 'env_secrets.g.dart';

@envied
abstract class Env {
  @EnviedField(varName: 'GOOGLE_MAPS_API_KEY')
  static const String googleMapsAPIKEY = _Env.googleMapsAPIKEY;

  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static const String openAIAPIKEY = _Env.openAIAPIKEY;

  @EnviedField(varName: 'WEATHER_API_KEY')
  static const String weatherAPIKEY = _Env.weatherAPIKEY;
}
