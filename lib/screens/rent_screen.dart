import 'package:flutter/material.dart';

class RentScreen extends StatelessWidget {
  final String propertyName;
  final int rentalAmount;
  final List<dynamic> rentRecords;

  RentScreen({
    required this.propertyName,
    required this.rentalAmount,
    required this.rentRecords,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              propertyName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Rental Amount: \$${rentalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Year')),
                  DataColumn(label: Text('Month')),
                  DataColumn(label: Text('Rent Received')),
                ],
                rows: rentRecords.map((record) {
                  return DataRow(cells: [
                    DataCell(Text(record.year.toString())),
                    DataCell(Text(record.month)),
                    DataCell(
                        Text('\$${record.rentReceived.toStringAsFixed(2)}')),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
