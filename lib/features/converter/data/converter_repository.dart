import 'package:currency_converter/api_client/dio_client.dart';
import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/converter/domain/entities/rate_entity.dart';

class ConverterRepository {
  ConverterRepository(this._api);

  final DioClient _api;

  Future<List<CurrencyEntity>> fetchCurrencies() =>
      _api.get<JsonObject>(path: '/symbols').then((payload) {
        final list = (payload['symbols'] as JsonObject)
            .entries
            .map<CurrencyEntity>(
              (e) => CurrencyEntity.fromJson({
                'key': e.key,
                'value': e.value,
              }),
            )
            .toList();
        return list..removeWhere((e) => e is UnknownCurrencyEntity);
      });

  Future<RateEntity> getRateByCurrencies(JsonObject query) => _api
      .get<JsonObject>(path: '/latest', query: query)
      .then(RateEntity.fromJson);
}
