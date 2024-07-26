// information about the AllComment which will be rendered in datagrid.
import 'package:intl/intl.dart';

class AllComment {
  /// Creates the AllComment class with required details.
  AllComment(
    this.id,
    this.customerId,
    this.customerName,
    this.numberOfDaysLate,
    this.comment,
    this.createdAt,
  );

  /// Id of an AllComment.
  final int id;
  final String customerId;
  final String customerName;
  final String numberOfDaysLate;
  final String comment;
  final String createdAt;

  //fromjson
  factory AllComment.fromJson(Map<String, dynamic> json) {
    return AllComment(
        json['id'],
        json['customer']['customer_id'],
        json['customer']['names'],
        json['number_of_days_late'].toString(),
        json['comment'],
        json['created_at']);
  }

  String get formattedDate {
    final DateTime parsedDate = DateTime.parse(createdAt);
    return DateFormat('MMMM d, y').format(parsedDate);
  }
}
