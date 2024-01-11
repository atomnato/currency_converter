import 'package:currency_converter/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CurrencyField extends StatefulWidget {
  const CurrencyField({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final VoidCallback onTap;

  @override
  State<CurrencyField> createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: AppColors.outline,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: const TextField(keyboardType: TextInputType.number,)),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                onTap: widget.onTap,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text('USD',
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.primary,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
