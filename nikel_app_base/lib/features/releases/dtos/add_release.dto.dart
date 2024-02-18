class AddReleaseDTO {
  final double value;
  final String description;
  final DateTime date;
  final bool isInflow;

  const AddReleaseDTO({
    required this.value,
    required this.description,
    required this.date,
    required this.isInflow,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'isInflow': isInflow,
    };
  }
}
