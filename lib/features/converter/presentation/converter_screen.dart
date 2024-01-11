import 'package:currency_converter/features/converter/presentation/widgets/currency_dialog.dart';
import 'package:currency_converter/features/converter/presentation/widgets/currency_field.dart';
import 'package:currency_converter/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency converter')),
      body: Padding(
        padding: const EdgeInsets.only(top: 48, left: 16, right: 16),
        child: Column(
          children: [
            CurrencyField(
              label: 'You send',
              onTap: () => CurrencyDialog.show(context,['USD','USD','USD','USD','USD','USD','USD','USD','USD','USD']),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Icon(
                Icons.currency_exchange,
                color: AppColors.primary,
              ),
            ),
            CurrencyField(
              label: 'They get',
              onTap: () => CurrencyDialog.show(context,['USD','USD','USD','USD','USD','USD','USD','USD','USD','USD']),
            ),
          ],
        ),
      ),
    );
  }
}
