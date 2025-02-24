class RentRecord {
  final int year;
  final String month;
  final double rentReceived;

  RentRecord({
    required this.year,
    required this.month,
    required this.rentReceived,
  });

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'month': month,
      'rentReceived': rentReceived,
    };
  }

  factory RentRecord.fromMap(Map<String, dynamic> map) {
    return RentRecord(
      year: map['year'],
      month: map['month'],
      rentReceived: map['rentReceived'],
    );
  }
}
