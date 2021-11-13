import 'package:flutter/material.dart';

class CheckboxListFilter extends StatefulWidget {
  const CheckboxListFilter({
    required this.filterName,
    required this.categories,
    required this.initialCategories,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final List<String> categories;
  final List<String> initialCategories;
  final Function(List<String>) onChange;
  final String filterName;

  @override
  State<CheckboxListFilter> createState() => _CheckboxListFilterState();
}

class _CheckboxListFilterState extends State<CheckboxListFilter> {
  late List<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = widget.initialCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.filterName,
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: widget.categories.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return CheckboxListTile(
                  value: selectedValues.contains(category),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(category),
                  onChanged: (bool? isSelected) {
                    if (isSelected == null) {
                      return;
                    }
                    setState(() {
                      if (isSelected) {
                        selectedValues.add(category);
                      } else {
                        selectedValues.remove(category);
                      }
                    });

                    widget.onChange(selectedValues);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
