import 'package:onfly_app/data/utils/exceptions/map_value_exception.dart';

extension MapExtension on Map {
  dynamic getValue<T>({required T key}) {
    var value = this[key];

    if (value == null) throw MapValueException(key);

    return value;
  }
}
