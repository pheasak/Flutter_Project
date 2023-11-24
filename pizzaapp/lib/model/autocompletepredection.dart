class AutocompletePredection {
  final String? description;
  final StructuredFormatting? structuredFormatting;
  final String? placeid;
  final String? reference;
  AutocompletePredection(
      {this.description,
      this.placeid,
      this.structuredFormatting,
      this.reference});
  factory AutocompletePredection.fromjson(Map<String, dynamic> json) {
    return AutocompletePredection(
      description: json['description'] as String?,
      placeid: json['place_id'] as String,
      reference: json['reference'] as String,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
    );
  }
}

class StructuredFormatting {
  final String? mainText;
  final String? secondaryText;
  StructuredFormatting({this.mainText, this.secondaryText});
  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
        mainText: json['main_text'] as String?,
        secondaryText: json['secondary_text'] as String);
  }
}
