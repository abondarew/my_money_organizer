class DocumentReadModel {
  final String id;
  final DateTime dateDocument;
  final String category;
  final String description;
  final double amount;
  final String currency;
  final double currencyAmount;

  DocumentReadModel(
      {required this.id,
      required this.dateDocument,
      required this.category,
      required this.description,
      required this.amount,
      required this.currency,
      required this.currencyAmount});
}
