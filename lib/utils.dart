import 'package:intl/intl.dart';

String formattedDate(num timestamp) {
  var dateTimeObj = DateTime.fromMillisecondsSinceEpoch(timestamp as int);
  var formatter = DateFormat("EEE, d MMM yyyy");
  return formatter.format(dateTimeObj);
}