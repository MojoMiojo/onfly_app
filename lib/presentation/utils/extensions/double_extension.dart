import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatToMoney({String? symbol = 'R\$'}) {
    try {
      var formated =
          NumberFormat.currency(
        locale: 'pt',
        symbol: symbol,
        decimalDigits: 2,
      ).format(this);
      return formated.trim();
    } catch (e) {
      return "";
    }
  }
}
