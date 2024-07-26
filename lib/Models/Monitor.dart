// information about the Monitor which will be rendered in datagrid.
class Monitor {
  /// Creates the Monitor class with required details.
  Monitor(
    this.id,
    this.name,
    this.phone,
    this.location,
    this.activity,
    this.appraisalDate,
    this.marketingDate,
    this.applicationDate,
  );

  /// Id of an Monitor.
  final int id;
  final String name;
  final String phone;
  final String location;
  final String activity;
  String? appraisalDate;
  String? marketingDate;
  String? applicationDate;

  //fromjson
  factory Monitor.fromJson(Map<String, dynamic> json) {
    return Monitor(
      json['id'],
      json['name'],
      json['phone'],
      json['location'],
      json['activity'],
      json['appraisal_date'],
      json['created_at'],
      json['application_date'],
    );
  }
}
