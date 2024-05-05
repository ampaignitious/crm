// information about the Arrear which will be rendered in datagrid.
class Dashboard {  
  /// Creates the Arrear class with required details.
  Dashboard(
      this.outstandingPrincipal,
      this.outstandingInterest,
      this.principalArrears,
      this.numberOfFemaleBorrowers,
      this.numberOfChildren,
      this.totalDisbursements,
      this.par30Days,
      this.par1Days,
      this.numberOfClients,
      this.numberOfGroups,
      this.numberOfIndividuals,
      this.sgl
      );

  /// Id of an Arrear.
  final String outstandingPrincipal;
  final String outstandingInterest;
  final String principalArrears;
  final String numberOfFemaleBorrowers;
  final String numberOfChildren;
  final String totalDisbursements;
  final String par30Days;
  final String par1Days;
  final String numberOfClients;
  final String numberOfGroups;
  final String numberOfIndividuals;
  final String sgl;

  //fromjson
  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      json['outstanding_principal'].toString(),
      json['outstanding_interest'].toString(),
      json['principal_arrears'].toString(),
      json['number_of_female_borrowers'].toString(),
      json['number_of_children'].toString(),
      json['total_disbursements'].toString(),
      json['par_30_days'].toString(),
      json['par_1_days'].toString(),
      json['number_of_clients'].toString(),
      json['number_of_groups'].toString(),
      json['number_of_individuals'].toString(),
      json['sgl'].toString(),
    );
  }
}
