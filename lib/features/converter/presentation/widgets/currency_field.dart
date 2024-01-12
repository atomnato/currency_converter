import 'package:currency_converter/features/converter/domain/entities/currency_entity.dart';
import 'package:currency_converter/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CurrencyField extends StatefulWidget {
  const CurrencyField({
    required this.label,
    required this.builder,
    required this.enabled,
    required this.value,
    this.onSubmitted,
    super.key,
  });

  final String label;
  final String value;
  final bool enabled;
  final Widget Function(BuildContext) builder;
  final void Function(String)? onSubmitted;

  @override
  State<CurrencyField> createState() => _CurrencyFieldState();
}

class _CurrencyFieldState extends State<CurrencyField> {
  late TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.value);
  }
  @override
  void didUpdateWidget(covariant CurrencyField oldWidget) {
    if(oldWidget.value != widget.value){
      _textController.text = widget.value;
    }
    super.didUpdateWidget(oldWidget);
  }
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
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
            Expanded(
              child: TextField(
                controller: _textController,
                onSubmitted: widget.onSubmitted,
                enabled: widget.enabled,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: widget.builder(context),
            ),
          ],
        ),
      ],
    );
  }
}

class CurrencyDropdownList extends StatelessWidget {
  const CurrencyDropdownList({
    required this.onTap,
    required this.initialValue,
    super.key,
  });

  final VoidCallback onTap;
  final CurrencyEntity initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              initialValue.toJson().values.first.toString(),
              style: theme.textTheme.titleMedium!.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
