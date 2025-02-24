class Property {
  final String name;
  final String address;
  final int rent;
  final List<dynamic> rentRecord;

  Property(this.name, this.address, this.rent, [List<dynamic>? rentRecord])
      : rentRecord = rentRecord ?? [];
}
