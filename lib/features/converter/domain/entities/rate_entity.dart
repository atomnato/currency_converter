import 'package:currency_converter/api_client/dio_client.dart';
import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rate_entity.freezed.dart';

part 'rate_entity.g.dart';

@freezed
class RateEntity with _$RateEntity {

  const factory RateEntity({
    required CurrencyEntity currency,
    required double rate,
  }) = _RateEntity;
  const RateEntity._();

  factory RateEntity.fromJson(Map<String, dynamic> json) =>
      _customFromJson(json);

  static RateEntity _customFromJson(Map<String, dynamic> json){
      final rates = json['rates'] as JsonObject;
      final convertJson = {
        'currency': {'key': rates.keys.first},
        'rate': double.parse(rates.values.first.toString()),
      };
      return _$RateEntityFromJson(convertJson);
  }
}
