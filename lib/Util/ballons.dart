import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vfu/Utils/AppColors.dart'; // Import the intl package

class BalloonCard extends StatefulWidget {
  final dynamic snapshot; // Assuming you have snapshot data passed here

  BalloonCard({required this.snapshot});

  @override
  _BalloonCardState createState() => _BalloonCardState();
}

class _BalloonCardState extends State<BalloonCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  String formatNumber(String value, {bool withSymbol = false}) {
    final number = int.tryParse(value) ?? 0;
    final format = NumberFormat('#,###');
    final formattedValue = format.format(number);
    return withSymbol ? '$formattedValue /=' : formattedValue;
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.snapshot.data![0]; // Assuming snapshot.data![0] is your data object
    final items = [
      {'title': 'Total Incentive', 'value': formatNumber(data.totalIncentive, withSymbol: true), 'isTotalIncentive': true},
      {'title': 'Officer ID', 'value': data.OfficerId},
      {'title': 'Full Name', 'value': data.name},
      {'title': 'Outstanding Principal (Individual)', 'value': formatNumber(data.outstandingPrincipalIndividual, withSymbol: true)},
      {'title': 'Outstanding Principal (Group)', 'value': formatNumber(data.outstandingPrincipalGroup, withSymbol: true)},
      {'title': 'No of Customers (Individual)', 'value': data.noOfCustomersIndividual},
      {'title': 'No of Customers (Group)', 'value': data.noOfCustomersGroup},
      {'title': 'PAR >1 Day (%)', 'value': data.par1Day},
      {'title': 'llr', 'value': data.llr},
      {'title': 'sgl', 'value': data.sgl},
      {'title': 'Incentive (PAR >1 Day)', 'value': formatNumber(data.incentivePar1Day, withSymbol: true)},
      {'title': 'Incentive (Net Portfolio Growth)', 'value': formatNumber(data.incentiveNetPortifolioGrowth, withSymbol: true)},
      {'title': 'Incentive (Net Client Growth)', 'value': formatNumber(data.incentiveNetClientGrowth, withSymbol: true)},
    ];

    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Stack(
          children: [
            // Balloons background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: BalloonPainter(_animation.value),
                    child: Container(),
                  );
                },
              ),
            ),
            // Main content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: items.map((item) {
                    bool isTotalIncentive = item['isTotalIncentive'] ?? false;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        color: isTotalIncentive ? AppColors.contentColorOrange : Colors.white,
                        elevation: isTotalIncentive ? 12 : 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title text
                              Text(
                                item['title']!,
                                style: TextStyle(
                                  fontWeight: isTotalIncentive ? FontWeight.bold : FontWeight.normal,
                                  fontSize: 18,
                                  color: isTotalIncentive ? Colors.black87 : Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8.0), // Space between title and value
                              // Value text
                              Text(
                                item['value']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isTotalIncentive ? FontWeight.bold : FontWeight.normal,
                                  color: isTotalIncentive ? Colors.black87 : Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class BalloonPainter extends CustomPainter {
  final double animationValue;

  BalloonPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.contentColorOrange.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final double balloonSize = 50 + 50 * animationValue;
    final double offset = 100 * animationValue;

    for (int i = 0; i < 10; i++) {
      final double x = (i * 100) % size.width;
      final double y = (size.height - offset - (i * 50)) % size.height;

      canvas.drawCircle(Offset(x, y), balloonSize, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
