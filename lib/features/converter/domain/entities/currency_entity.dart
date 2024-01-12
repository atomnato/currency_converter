import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_entity.freezed.dart';

part 'currency_entity.g.dart';

@Freezed(unionKey: 'key', fallbackUnion: 'unknown')
class CurrencyEntity with _$CurrencyEntity {
  const CurrencyEntity._();

  const factory CurrencyEntity.unknown() = UnknownCurrencyEntity;

  @FreezedUnionValue('USD')
  const factory CurrencyEntity.usd() = _USDCurrencyEntity;

  @FreezedUnionValue('AED')
  const factory CurrencyEntity.aed() = _AEDCurrencyEntity;

  @FreezedUnionValue('AFN')
  const factory CurrencyEntity.afn() = _AFNCurrencyEntity;

  @FreezedUnionValue('ALL')
  const factory CurrencyEntity.all() = ALLCurrencyEntity;

  @FreezedUnionValue('AMD')
  const factory CurrencyEntity.amd() = _AMDCurrencyEntity;

  @FreezedUnionValue('ANG')
  const factory CurrencyEntity.ang() = _ANGCurrencyEntity;

  @FreezedUnionValue('AOA')
  const factory CurrencyEntity.aoa() = _AOACurrencyEntity;

  @FreezedUnionValue('ARS')
  const factory CurrencyEntity.ars() = _ARSCurrencyEntity;

  @FreezedUnionValue('JPY')
  const factory CurrencyEntity.jpy() = _JPYCurrencyEntity;

  @FreezedUnionValue('EUR')
  const factory CurrencyEntity.eur() = EURCurrencyEntity;

  @FreezedUnionValue('GBP')
  const factory CurrencyEntity.gbp() = _GBPCurrencyEntity;

  @FreezedUnionValue('CAD')
  const factory CurrencyEntity.cad() = _CADCurrencyEntity;

  factory CurrencyEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrencyEntityFromJson(json);
}
