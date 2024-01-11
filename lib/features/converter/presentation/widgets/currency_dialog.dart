import 'package:flutter/material.dart';

class CurrencyDialog extends StatelessWidget {
  const CurrencyDialog({required this.currencies, super.key});

  static Future<void> show(BuildContext context, List<String> currencies) async {
    return showDialog(
      context: context,
      builder: (context) => CurrencyDialog(currencies: currencies),
    );
  }

  final List<String> currencies;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Choose a currency'),
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
            //widget.onOk();
          },
        ),
      ],
      content: SingleChildScrollView(
        child: Container(
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
                    itemCount: currencies.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                          title: Text(currencies[index]),
                          value: index,
                          groupValue: 1,
                          onChanged: (value) {
                            // setState(() {
                            //   _selected = index;
                            // });
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
