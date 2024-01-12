import 'dart:async';

import 'package:currency_converter/api_client/models/api_error.dart';
import 'package:currency_converter/features/converter/data/converter_repository.dart';
import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:currency_converter/storage/isar_service.dart';
import 'package:flutter/material.dart';

class ConverterInteractor extends ChangeNotifier {
  ConverterInteractor(this._repository, this._dataBase) {
    _fetchCurrencies();
  }

  final ConverterRepository _repository;
  final IsarService _dataBase;

  List<CurrencyEntity> _currencies = [];

  List<CurrencyEntity> get currencies => _currencies;

  Future<void> _fetchCurrencies() async {
    _currencies = await _repository.fetchCurrencies();
    notifyListeners();
  }

  Future<double> getCurrencyExchangeRate(
    CurrencyEntity fromCurrency,
    CurrencyEntity toCurrency,
    double fromValue,
  ) async {
    final queryParameters = {
      'base': fromCurrency.toJson().values.first,
      'symbols': toCurrency.toJson().values.first,
    };
    try {
      final response = await _repository.getRateByCurrencies(queryParameters);

      final toCurrencyString = toCurrency.toJson().values.first.toString();
      unawaited(_dataBase.addCurrencyRate(response.rate, toCurrencyString));

      return response.rate * fromValue;
    } on ApiError catch (e) {
      if (e is ApiInvalidResponseError) {
        final toCurrencyString = toCurrency.toJson().values.first.toString();
        final rateFromDB = await _dataBase.getCurrencyRate(toCurrencyString);

        if (rateFromDB == null) {
          rethrow;
        }

        return rateFromDB * fromValue;
      } else {
        rethrow;
      }
    } on Exception {
      rethrow;
    }
  }
}
