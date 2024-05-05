class ArrearTableHeaders {

  var headers = {
    "staff_id": {
      "officerId": "Officer ID",
      "name": "Name",
      "clients": "Clients",
      "utstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "branch_id": {
      "branch": "Branch",
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "region_id": {
      "region": "Region",
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "loan_product": {
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "gender": {
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "district": {
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "sub_county": {
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "village": {
      "name": "Name",
      "clients": "Clients",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "clientsInArrears": "Clients in Arrears",
      "parDay": "Par>1 Day(%)"
    },
    "client": {
      "name": "Name",
      "phone": "Phone",
      "comments": "comments",
      "amountDisbursed": "Amount Disbursed",
      "outstandingPrincipal": "Outstanding Principal",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
      "numberOfDaysLate": "Number Of Days Late",
      "actions": "actions"
    },
    "age": {
      "ageBracket": "Age Bracket",
      "numberOfClients": "Number of clients",
      "principleArrears": "Principle Arrears",
      "interestArrears": "Interest Arrears",
      "totalArrears": "Total Arrears",
    },
  };

  Map<String, String>? getHeaders(String key) {
    return headers[key];
  }

  //get keys within the selected key
  List<String> getKeys(String key) {
    return headers[key]!.keys.toList();
  }
}
