import 'package:flutter/material.dart';

import '../../../../constants/app_margins_and_sizes.dart';

class RadioButtonListFilter extends StatefulWidget {
  const RadioButtonListFilter({
    required this.filterName,
    required this.categories,
    required this.initialCategory,
    required this.onChange,
    this.searchEnabled = false,
    Key? key,
  }) : super(key: key);

  final List<String> categories;
  final String? initialCategory;
  final Function(String?) onChange;
  final String filterName;
  final bool searchEnabled;

  @override
  State<RadioButtonListFilter> createState() => _RadioButtonListFilterState();
}

class _RadioButtonListFilterState extends State<RadioButtonListFilter> {
  String? selected;
  late List<String> filteredCategories;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    selected = widget.initialCategory;
    filteredCategories = widget.categories;
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
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
        if (widget.searchEnabled)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: generalPadding),
            child: TextField(
              autocorrect: false,
              onChanged: (value) {
                setState(() {
                  filteredCategories = widget.categories
                      .where((category) =>
                          category.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            child: ListView.builder(
              controller: scrollController,
              itemCount: filteredCategories.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                return RadioListTile<String?>(
                  toggleable: true,
                  groupValue: selected,
                  value: category,
                  title: Text(category),
                  onChanged: (String? value) {
                    setState(() {
                      selected = value;
                    });
                    widget.onChange(value);
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
