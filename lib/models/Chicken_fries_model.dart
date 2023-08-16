class ChikckenFries {
  String? friesQuantity;
  String? chickenQuantity;
  String? id;
  ChikckenFries(this.friesQuantity, this.chickenQuantity);
  factory ChikckenFries.fromJson(json) {
    return ChikckenFries(
      json['fries'] as String,
      json['chicken'] as String,
    );
  }
}
