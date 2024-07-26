// information about the Comment which will be rendered in datagrid.
import 'package:intl/intl.dart';

class Comment {
  /// Creates the Comment class with required details.
  Comment(
    this.id,
    this.comment,
    this.createdAt,
  );

  /// Id of an Comment.
  final int id;
  final String comment;
  final String createdAt;

  //fromjson
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json['id'],
      json['comment'],
      json['created_at'],
    );
  }

    String get formattedDate {
    final DateTime parsedDate = DateTime.parse(createdAt);
    return DateFormat('MMMM d, y').format(parsedDate);
  }
}
