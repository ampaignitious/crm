class LoanSchedule {
  final DateTime date;
  final double base;
  final double percent;
  final double installment;
  final double balance;

  LoanSchedule({
    required this.date,
    required this.base,
    required this.percent,
    required this.installment,
    required this.balance,
  });
}