import 'package:flutter/material.dart';
import 'package:rently/models/property.dart';
import 'package:rently/models/rent.dart';
import 'package:rently/services/firebase_services.dart';

class RentScreen extends StatefulWidget {
  final Property property;

  RentScreen({
    required this.property,
  });

  @override
  _RentScreenState createState() => _RentScreenState();
}

class _RentScreenState extends State<RentScreen> {
  String selectedMonth = 'January';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent Details'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.property.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Rental Amount: \$${widget.property.rent.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: RentTable(widget: widget),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Total Rent Received for the Year: \$${(widget.property.rent * widget.property.rentRecord.length).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AddRentButton(context),
    );
  }

  FloatingActionButton AddRentButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DropdownButton<String>(
                        value: selectedMonth,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setModalState(() {
                              selectedMonth = newValue;
                            });
                          }
                        },
                        items: <String>[
                          'January',
                          'February',
                          'March',
                          'April',
                          'May',
                          'June',
                          'July',
                          'August',
                          'September',
                          'October',
                          'November',
                          'December'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      SubmitButton(context),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Icon(Icons.add),
    );
  }

  ElevatedButton SubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add the rent record for the selected month
        widget.property.rentRecord.add(
          RentRecord(
            year: DateTime.now().year,
            month: selectedMonth,
            rentReceived: widget.property.rent.toDouble(),
          ),
        );
        // Update the screen to show the new record
        setState(() {});
        FirebaseService().updateProperty(
          widget.property.name,
          widget.property,
        );
        Navigator.pop(context);
      },
      child: Text('Confirm'),
    );
  }
}

class RentTable extends StatelessWidget {
  const RentTable({
    super.key,
    required this.widget,
  });

  final RentScreen widget;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Year')),
        DataColumn(label: Text('Month')),
        DataColumn(label: Text('Rent Received')),
      ],
      rows: widget.property.rentRecord.map((RentRecord record) {
        return DataRow(cells: [
          DataCell(Text(record.year.toString())),
          DataCell(Text(record.month)),
          DataCell(Text('\$${record.rentReceived.toStringAsFixed(2)}')),
        ]);
      }).toList(),
    );
  }
}
