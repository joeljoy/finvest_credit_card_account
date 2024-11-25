// ignore_for_file: constant_identifier_names

class TransactionChip {
  final String id;
  final String label;
  final bool isActive;
  final ChipType type;
  
  TransactionChip({
    required this.isActive,
    required this.type,
    required this.id,
    required this.label,
  });
}

enum ChipType { Sort, Filter, FilterItem }
