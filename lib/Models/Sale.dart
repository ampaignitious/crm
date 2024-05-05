// information about the Sale which will be rendered in datagrid.
class Sale {
  /// Creates the Sale class with required details.
  Sale(
      {this.regionName,
      this.branchName,
      this.totalDisbursementAmount,
      this.targetAmount,
      this.balance,
      this.targetClients,
      this.actualClients,
      this.productName,
      this.staffId,
      this.name,
      this.numberOfClients,
      this.score,
      this.regionId});

  /// Id of an Sale.
  String? regionName;
  String? branchName;
  String? totalDisbursementAmount;
  String? targetAmount;
  String? balance;
  String? targetClients;
  String? actualClients;
  String? score;
  String? productName;
  String? staffId;
  String? name;
  String? numberOfClients;
  String? regionId;

  //fromjson
  factory Sale.fromJson(Map<String, dynamic> json, String selected) {
    //check for 'Product','Branch->Loan Disbursed','Branch->Clients','Officer','Region->Loan Disbursed','Region->Clients',
    if (selected == 'Product') {
      return Sale(
          productName: json['product_name'],
          totalDisbursementAmount: json['total_disbursement_amount'].toString(),
          branchName: json['branch_name'],
          targetAmount: json['target_amount'].toString(),
          balance: json['balance'].toString(),
          targetClients: json['target_clients'].toString(),
          actualClients: json['actual_clients'].toString(),
          score: json['score'].toString(),
          staffId: json['staff_id'].toString());
    } else if (selected == 'Branch->Loan Disbursed' ||
        selected == 'Branch->Clients') {
      return Sale(
          regionName: json['region_name'],
          branchName: json['branch_name'],
          totalDisbursementAmount: json['total_disbursement_amount'].toString(),
          targetAmount: json['target_amount'].toString(),
          balance: json['balance'].toString(),
          targetClients: json['target_clients'].toString(),
          actualClients: json['actual_clients'].toString(),
          score: json['score'].toString(),
          staffId: json['staff_id'].toString());
    } else if (selected == 'Officer') {
      return Sale(
          staffId: json['staff_id'].toString(),
          name: json['names'],
          totalDisbursementAmount: json['total_disbursement_amount'].toString(),
          numberOfClients: json['number_of_clients'].toString());
    } else if (selected == 'Region->Loan Disbursed' ||
        selected == 'Region->Clients') {
      return Sale(
          regionId: json['region_id'].toString(),
          regionName: json['region_name'],
          totalDisbursementAmount: json['total_disbursement_amount'].toString(),
          targetAmount: json['target_amount'].toString(),
          balance: json['balance'].toString(),
          targetClients: json['target_clients'].toString(),
          actualClients: json['actual_clients'].toString(),
          score: json['score'].toString());
    } else {
      return Sale(
          productName: json['product_name'],
          totalDisbursementAmount: json['total_disbursement_amount'].toString(),
          branchName: json['branch_name'],
          targetAmount: json['target_amount'].toString(),
          balance: json['balance'].toString(),
          targetClients: json['target_clients'].toString(),
          actualClients: json['actual_clients'].toString(),
          score: json['score'].toString(),
          staffId: json['staff_id'].toString());
    }
  }
}
