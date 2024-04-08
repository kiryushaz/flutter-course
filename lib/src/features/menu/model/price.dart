class Price {
  final String value;
  final String currency;

  const Price({required this.value, required this.currency});

  @override
  String toString() => '$value $currency';

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        value: json["value"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "currency": currency,
      };
}
