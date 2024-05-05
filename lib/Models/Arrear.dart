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
      this.par1Day);

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
  final String par1Day;

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
      json['total_par'],
    );
  }
}
