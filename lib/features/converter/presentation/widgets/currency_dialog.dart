import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:flutter/material.dart';

class CurrencyDialog extends StatefulWidget {
  const CurrencyDialog({
    required this.currencies,
    required this.currentCurrency,
    required this.callback,
    super.key,
  });

  static Future<void> show(
    BuildContext context, {
    required List<CurrencyEntity> currencies,
    required CurrencyEntity currentCurrency,
    required void Function(CurrencyEntity) callback,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => CurrencyDialog(
        currencies: currencies,
        currentCurrency: currentCurrency,
        callback: callback,
      ),
    );
  }

  final List<CurrencyEntity> currencies;
  final CurrencyEntity currentCurrency;
  final void Function(CurrencyEntity) callback;

  @override
  State<CurrencyDialog> createState() => _CurrencyDialogState();
}

class _CurrencyDialogState extends State<CurrencyDialog> {
  late int _selectedIndex =
      widget.currencies.indexWhere((e) => e == widget.currentCurrency);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose a currency'),
      actions: <Widget>[
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            widget.callback(widget.currencies[_selectedIndex]);
            Navigator.maybePop(context);
          },
        ),
      ],
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.currencies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                      title: Text(
                        widget.currencies[index]
                            .toJson()
                            .values
                            .first
                            .toString(),
                      ),
                      value: index,
                      groupValue: _selectedIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
