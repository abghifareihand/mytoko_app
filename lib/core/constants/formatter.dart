import 'package:intl/intl.dart';

String priceFormat(dynamic price) {
  final currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );
  return currencyFormat.format(price);
}

String dateFormat(DateTime dateTime) {
  // ubah respon "created_at": "2024-05-08T09:37:06.000000Z",
  return DateFormat('dd MMMM yyyy, HH:mm:ss').format(dateTime);
}
