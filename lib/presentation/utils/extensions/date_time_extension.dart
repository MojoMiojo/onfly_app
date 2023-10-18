import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String brazillianDateFormat() {
    return DateFormat("dd/MM/yyyy", 'pt_BR').format(this);
  }

  String toTextDate() {
    return brazillianDateFormat().toString().replaceAll('/', '');
  }
}
