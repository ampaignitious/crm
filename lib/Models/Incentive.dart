// information about the Incentive which will be rendered in datagrid.
class Incentive {
  /// Creates the Incentive class with required details.
  Incentive(
      this.OfficerId,
      this.name,
      this.outstandingPrincipalIndividual,
      this.outstandingPrincipalGroup,
      this.outstandingPrincipalSgl,
      this.noOfCustomersIndividual,
      this.noOfCustomersGroup,
      this.par1Day,
      this.llr,
      this.sgl,
      this.incentiveType,
      this.incentivePar1Day,
      this.incentiveNetPortifolioGrowth,
      this.incentiveNetClientGrowth,
      this.totalIncentive);

  final String OfficerId;
  final String name;
  final String outstandingPrincipalIndividual;
  final String outstandingPrincipalGroup;
  final String outstandingPrincipalSgl;
  final String noOfCustomersIndividual;
  final String noOfCustomersGroup;
  final String par1Day;
  final String llr;
  final String sgl;
  final String incentiveType;
  final String incentivePar1Day;
  final String incentiveNetPortifolioGrowth;
  final String incentiveNetClientGrowth;
  final String totalIncentive;
  //fromjson
  factory Incentive.fromJson(Map<String, dynamic> json) {
    return Incentive(
      json['officer_details']['staff_id'].toString(),
      json['officer_details']['names'],
      json['incentive']['outstanding_principal_individual'].toString(),
      json['incentive']['outstanding_principal_group'].toString(),
      json['incentive']['outstanding_principal_sgl'].toString(),
      json['incentive']['unique_customer_id_individual'].toString(),
      json['incentive']['records_for_unique_group_id_group'].toString(),
      json['incentive']['records_for_PAR'].toString(),
      json['incentive']['monthly_loan_loss_rate'].toString(),
      json['incentive']['sgl_records'].toString(),
      json['incentive']['incentive_type'],
      json['incentive']['incentive_amount_PAR'].toString(),
      json['incentive']['incentive_amount_Net_Portifolio_Growth'].toString(),
      json['incentive']['incentive_amount_Net_Client_Growth'].toString(),
      json['incentive']['total_incentive_amount'].toString(),
    );
  }
}
