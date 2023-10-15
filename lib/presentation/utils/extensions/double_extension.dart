import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatToMoney() {
    try {
      var formated =
          NumberFormat.currency(locale: 'pt', symbol: 'R\$').format(this);
      return formated;
    } catch (e) {
      return "";
    }
  }
}
