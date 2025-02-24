import 'package:rently/models/rent.dart';

class Property {
  final String name;
  final String address;
  final int rent;
  final List<RentRecord> rentRecord;

  Property(this.name, this.address, this.rent, [List<RentRecord>? rentRecord])
      : rentRecord = rentRecord ?? [];
}
