// information about the Arrear which will be rendered in datagrid.
class Arrear {  
  /// Creates the Arrear class with required details.
  Arrear(
      this.id,
      this.OfficerId,
      this.name,
      this.clients,
      this.outstandingPrincipal,
      this.principalArrears,
      this.interestArrears,
      this.totalArrears,
      this.clientsInArrears,
      this.numberOfDaysLate,
      this.amountDisbursed,
      this.par1Day,
      this.numberOfComments,
      this.customerId,
      );

  /// Id of an Arrear.
  final String id;
  final String OfficerId;
  final String name;
  final String clients;
  final String outstandingPrincipal;
  final String principalArrears;
  final String interestArrears;
  final String totalArrears;
  final String clientsInArrears;
  final String numberOfDaysLate;
  final String amountDisbursed;
  final String par1Day;
  final String numberOfComments;
  final String customerId;

  //fromjson
  factory Arrear.fromJson(Map<String, dynamic> json) {
    return Arrear(
      json['arrear_id'].toString(),
      json['group_key'].toString(),
      json['names'],
      json['total_clients'].toString(),
      json['total_outstanding_principal'].toString(),
      json['total_principle_arrears'].toString(),
      json['total_interest_arrears'].toString(),
      json['total_arrears'].toString(),
      json['clients_in_arrears'].toString(),
      json['number_of_days_late'].toString(),
      json['amount_disbursed'].toString(),
      json['total_par'],
      json['number_of_comments'].toString(),
      json['customer_id'].toString(),
    );
  }
}
