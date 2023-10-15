import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String brazillianDateFormat() {
    return DateFormat("dd/MM/yyyy", 'pt_BR').format(this);
  }
}
