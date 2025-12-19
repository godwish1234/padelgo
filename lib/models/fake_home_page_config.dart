import 'package:json_annotation/json_annotation.dart';

part 'fake_home_page_config.g.dart';

@JsonSerializable(explicitToJson: true)
class FakeHomePageConfig {
  @JsonKey(name: 'maxAllowance')
  final String? maxAllowance;

  @JsonKey(name: 'businessDesc')
  final String? businessDesc;

  @JsonKey(name: 'tenorHari')
  final String? tenorHari;

  @JsonKey(name: 'BungaHari')
  final String? bungaHari;

  @JsonKey(name: 'Berizin')
  final String? berizin;

  const FakeHomePageConfig({
    this.maxAllowance,
    this.businessDesc,
    this.tenorHari,
    this.bungaHari,
    this.berizin,
  });

  factory FakeHomePageConfig.fromJson(Map<String, dynamic> json) =>
      _$FakeHomePageConfigFromJson(json);

  Map<String, dynamic> toJson() => _$FakeHomePageConfigToJson(this);

  int getMaxAllowanceAsInt({int fallback = 4800000}) {

    if (maxAllowance == null || maxAllowance!.isEmpty) {
      return fallback;
    }

    final cleanedValue = maxAllowance!.trim();
    final parsed = int.tryParse(cleanedValue);

    return parsed ?? fallback;
  }

  int getMaxAllowanceAsIntStrict() {
    if (maxAllowance == null || maxAllowance!.isEmpty) {
      throw ArgumentError('maxAllowance is null or empty');
    }

    final cleanedValue = maxAllowance!.trim();
    final parsed = int.tryParse(cleanedValue);

    if (parsed == null) {
      throw FormatException(
          'Cannot parse maxAllowance: "$maxAllowance" (cleaned: "$cleanedValue")');
    }

    return parsed;
  }

  int getTenorHariAsInt({int fallback = 180}) {
    if (tenorHari == null || tenorHari!.isEmpty) {
      return fallback;
    }
    return int.tryParse(tenorHari!) ?? fallback;
  }

  double getBungaHariAsDouble({double fallback = 0.03}) {
    if (bungaHari == null || bungaHari!.isEmpty) {
      return fallback;
    }
    return double.tryParse(bungaHari!) ?? fallback;
  }
}
