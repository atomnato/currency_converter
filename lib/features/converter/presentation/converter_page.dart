import 'package:currency_converter/features/converter/domain/converter_interactor.dart';
import 'package:currency_converter/features/converter/presentation/converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterPage extends StatelessWidget {
  const ConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currencies = context.watch<ConverterInteractor>().currencies;

    return Scaffold(
      appBar: AppBar(title: const Text('Currency converter')),
      body: currencies.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ConverterScreen(currencies: currencies),
    );
  }
}
