// information about the Expected which will be rendered in datagrid.
class Expected {
  /// Creates the Expected class with required details.
  Expected({
    this.id,
    this.branchId,
    this.customerId,
    this.groupId,
    this.expectedPrincipal,
    this.expectedInterest,
    this.expectedTotal,
    this.clientsInArrears,
    this.totalClients,
    this.name,
    this.nextRepaymentDate,
    this.phoneNumber,
    this.numberOfComments,
    this.amountDisbursed,
    this.totalOutstandingPrincipal,
    this.nextRepaymentPrincipal,
    this.nextRepaymentInterest,
    this.totalPrincipalArrears,
    this.totalInterestArrears,
    this.totalPaymentAmount,
    this.numberOfDaysLate,
    this.addPerCustomer,
  });

  /// Id of an Expected.
  String? id;
  String? branchId;
  String? customerId;
  String? groupId;
  String? expectedPrincipal;
  String? expectedInterest;
  String? expectedTotal;
  String? clientsInArrears;
  String? totalClients;
  String? name;
  String? nextRepaymentDate;
  String? phoneNumber;
  String? numberOfComments;
  String? amountDisbursed;
  String? totalOutstandingPrincipal;
  String? nextRepaymentPrincipal;
  String? nextRepaymentInterest;
  String? totalPrincipalArrears;
  String? totalInterestArrears;
  String? totalPaymentAmount;
  String? numberOfDaysLate;
  String? addPerCustomer;
  //fromjson
  factory Expected.fromJson(Map<String, dynamic> json) {
    return Expected(
      id: json['arrear_id'].toString(),
      branchId: json['branch_id'].toString(),
      customerId: json['customer_id'].toString(),
      groupId: json['group_key'].toString(),
      expectedPrincipal: json['expected_principal'].toString(),
      expectedInterest: json['expected_interest'].toString(),
      expectedTotal: json['expected_total'].toString(),
      clientsInArrears: json['clients_in_arrears'].toString(),
      totalClients: json['total_clients'].toString(),
      name: json['names']==""?'N/A':json['names'],
      nextRepaymentDate: json['next_repayment_date']==""?'N/A':json['next_repayment_date'],
      phoneNumber: json['phone_number']==""?'N/A':json['phone_number'],
      numberOfComments: json['number_of_comments'].toString(),
      amountDisbursed: json['amount_disbursed'].toString(),
      totalOutstandingPrincipal: json['total_outstanding_principal'].toString(),
      nextRepaymentPrincipal: json['next_repayment_principal'].toString(),
      nextRepaymentInterest: json['next_repayment_interest'].toString(),
      totalPrincipalArrears: json['total_principle_arrears'].toString(),
      totalInterestArrears: json['total_interest_arrears'].toString(),
      totalPaymentAmount: json['total_payment_amount'].toString(),
      numberOfDaysLate: json['number_of_days_late'].toString(),
      addPerCustomer: json['add_per_customer'].toString(),
    );
  }
}
