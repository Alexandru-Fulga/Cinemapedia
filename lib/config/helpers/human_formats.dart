import 'package:intl/intl.dart';

class HumanFormat {
  static String number(double number, [int decimals = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'es',
    ).format(number);

    return formattedNumber;
  }

  static String date(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }
}
