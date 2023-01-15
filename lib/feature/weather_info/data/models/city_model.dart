import 'package:friflex_test_task/feature/weather_info/domain/entities/city_entity.dart';

// Модель для хранения названия города, наследующая соответствующую сущность и имеющая фабричный конструктор из json
class CityModel extends CityEntity {
  CityModel({
    required name,
  }) : super(
          name: name,
        );
  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
    );
  }
}
