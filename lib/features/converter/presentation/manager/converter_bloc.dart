import 'package:currency_converter/api_client/models/api_error.dart';
import 'package:currency_converter/features/converter/domain/converter_interactor.dart';
import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'converter_bloc.freezed.dart';

@freezed
class ConverterEvent with _$ConverterEvent {
  const factory ConverterEvent.calculateExchangeRate({String? fromValue}) =
      CalculateExchangeRateConverterEvent;

  const factory ConverterEvent.changeToCurrency({
    required CurrencyEntity toCurrency,
  }) = ChangeToCurrencyConverterEvent;
}

@freezed
class ConverterState with _$ConverterState {
  const factory ConverterState.init({
    CurrencyEntity? fromCurrency,
    CurrencyEntity? toCurrency,
    String? fromCurrencyValue,
    String? toCurrencyValue,
  }) = InitConverterState;

  const factory ConverterState.pending({
    CurrencyEntity? fromCurrency,
    CurrencyEntity? toCurrency,
    String? fromCurrencyValue,
    String? toCurrencyValue,
  }) = PendingConverterState;

  const factory ConverterState.success({
    CurrencyEntity? fromCurrency,
    CurrencyEntity? toCurrency,
    String? fromCurrencyValue,
    String? toCurrencyValue,
  }) = SuccessConverterState;

  const factory ConverterState.error({
    required Object error,
    CurrencyEntity? fromCurrency,
    CurrencyEntity? toCurrency,
    String? message,
    String? fromCurrencyValue,
    String? toCurrencyValue,
  }) = ErrorConverterState;
}

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  ConverterBloc(this._interactor)
      : super(
          ConverterState.init(
            fromCurrency: _interactor.currencies.firstWhere(
              (e) => e is EURCurrencyEntity,
            ),
            toCurrency: _interactor.currencies[1],
          ),
        ) {
    on<ConverterEvent>(
      (event, emit) => event.map<Future<void>>(
        calculateExchangeRate: (event) => _calculateExchangeRate(event, emit),
        changeToCurrency: (event) => _changeToCurenncy(event, emit),
      ),
    );
  }

  final ConverterInteractor _interactor;

  Future<void> _changeToCurenncy(
    ChangeToCurrencyConverterEvent event,
    Emitter<ConverterState> emitter,
  ) async {
    emitter(
      state.copyWith(
        fromCurrency: state.fromCurrency,
        fromCurrencyValue: state.fromCurrencyValue,
        toCurrency: event.toCurrency,
        toCurrencyValue: state.toCurrencyValue,
      ),
    );
  }

  Future<void> _calculateExchangeRate(
    CalculateExchangeRateConverterEvent event,
    Emitter<ConverterState> emitter,
  ) async {
    if (event.fromValue?.isEmpty ?? true) {
      return;
    }
    try {
      emitter(
        ConverterState.pending(
          fromCurrency: state.fromCurrency,
          fromCurrencyValue: event.fromValue,
          toCurrency: state.toCurrency,
          toCurrencyValue: state.toCurrencyValue,
        ),
      );
      final toCurrencyValue = await _interactor.getCurrencyExchangeRate(
        state.fromCurrency!,
        state.toCurrency!,
        double.parse(state.fromCurrencyValue!),
      );
      emitter(
        ConverterState.success(
          fromCurrency: state.fromCurrency,
          fromCurrencyValue: state.fromCurrencyValue,
          toCurrency: state.toCurrency,
          toCurrencyValue: toCurrencyValue.toStringAsFixed(2),
        ),
      );
    } on ApiError catch (e) {
      emitter(
        ConverterState.error(
          error: e,
          message: e.message,
          fromCurrency: state.fromCurrency,
          fromCurrencyValue: state.fromCurrencyValue,
          toCurrency: state.toCurrency,
          toCurrencyValue: state.toCurrencyValue,
        ),
      );
      rethrow;
    } on Exception catch (e) {
      emitter(
        ConverterState.error(
          error: e,
          fromCurrency: state.fromCurrency,
          fromCurrencyValue: state.fromCurrencyValue,
          toCurrency: state.toCurrency,
          toCurrencyValue: state.toCurrencyValue,
        ),
      );
      rethrow;
    }
  }
}
