import 'package:onfly_app/data/utils/exceptions/map_value_exception.dart';

extension MapExtension on Map {
  dynamic getValue<K>({required K key}) {
    var value = this[key];

    if (value == null) throw MapValueException();

    return value;
  }

  dynamic getValueOrDefault<K, T>({
    required K key,
    required T defaultValue,
  }) {
    var value = this[key];
    return value ?? defaultValue;
  }
}
