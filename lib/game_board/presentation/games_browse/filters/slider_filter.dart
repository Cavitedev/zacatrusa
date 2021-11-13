import 'package:flutter/material.dart';

class SliderFilter extends StatefulWidget {
  const SliderFilter({
    required this.filterName,
    required this.initialMinValue,
    required this.initialMaxValue,
    required this.minValue,
    required this.maxValue,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  final String filterName;
  final double initialMinValue;
  final double initialMaxValue;
  final double minValue;
  final double maxValue;
  final Function(double, double) onChange;

  @override
  _SliderFilterState createState() => _SliderFilterState();
}

class _SliderFilterState extends State<SliderFilter> {
  late RangeValues currentValues;

  @override
  void initState() {
    super.initState();
    currentValues = RangeValues(widget.initialMinValue, widget.initialMaxValue);
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
        RangeSlider(
          values: currentValues,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: (widget.maxValue - widget.minValue).round(),
          labels:
              RangeLabels("${currentValues.start}€", "${currentValues.end}€"),
          onChanged: (rangeValues) {
            setState(() {
              if (currentValues != rangeValues) {
                currentValues = RangeValues(rangeValues.start.roundToDouble(),
                    rangeValues.end.roundToDouble());
                widget.onChange(currentValues.start, currentValues.end);
              }
            });
          },
        )
      ],
    );
  }
}
