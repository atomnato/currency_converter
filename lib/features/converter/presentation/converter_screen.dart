import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:currency_converter/features/converter/presentation/manager/converter_bloc.dart';
import 'package:currency_converter/features/converter/presentation/widgets/currency_dialog.dart';
import 'package:currency_converter/features/converter/presentation/widgets/currency_field.dart';
import 'package:currency_converter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({required this.currencies, super.key});

  final List<CurrencyEntity> currencies;

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  late final ConverterBloc _bloc;
  final fromTextFieldKey = GlobalKey();
  final toTextFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ConverterBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterBloc, ConverterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
          child: Column(
            children: [
              CurrencyField(
                key: fromTextFieldKey,
                label: 'You send',
                enabled: state is! PendingConverterState,
                value: state.fromCurrencyValue ?? '',
                builder: (context) {
                  return CurrencyDropdownList(
                    initialValue: state.fromCurrency!,
                    onTap: () {},
                  );
                },
                onSubmitted: (value) {
                  _bloc.add(
                    ConverterEvent.calculateExchangeRate(fromValue: value),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Icon(
                  Icons.currency_exchange,
                  color: AppColors.primary,
                ),
              ),
              CurrencyField(
                key: toTextFieldKey,
                label: 'They get',
                enabled: false,
                value: state.toCurrencyValue ?? '',
                builder: (context) {
                  return CurrencyDropdownList(
                    initialValue: state.toCurrency!,
                    onTap: () => CurrencyDialog.show(
                      context,
                      currencies: widget.currencies,
                      currentCurrency: state.toCurrency!,
                      callback: (currency) {
                        _bloc.add(
                          ConverterEvent.changeToCurrency(toCurrency: currency),
                        );
                      },
                    ),
                  );
                },
              ),
              if (state is ErrorConverterState)
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.error.toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Flexible(child: Text(state.message ?? '')),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
