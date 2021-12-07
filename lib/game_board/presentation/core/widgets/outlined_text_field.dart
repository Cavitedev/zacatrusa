import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../constants/app_margins_and_sizes.dart';

class OutlinedTextField extends StatefulWidget {
  final String hintText;
  final bool autoFocus;
  final bool autocorrect;
  final EdgeInsets padding;
  final int? maxLines;

  /// With Radius.circular(12) by default
  final BorderRadius borderRadius;

  /// override outline when it is set
  final OutlineInputBorder? outlineInputBorder;

  final TextStyle? textStyle;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final Icon? prefixIcon;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final String helperText;
  final TextInputAction? textInputAction;

  final TextEditingController? controller;

  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Widget? suffixIconWhenNoText;

  const OutlinedTextField({
    Key? key,
    this.hintText = "",
    this.autocorrect = false,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIcon,
    this.focusNode,
    this.borderRadius = generalBorderRadius,
    this.inputFormatters,
    this.padding = EdgeInsets.zero,
    this.helperText = "",
    this.outlineInputBorder,
    this.controller,
    this.maxLines = 1,
    this.onChanged,
    this.suffixIconWhenNoText,
    this.textStyle,
    this.textInputAction,
    this.onSubmit,
  }) : super(key: key);

  @override
  _OutlinedTextFieldState createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  bool hasText = false;
  late TextEditingController textEditingController;
  String? helpText;

  @override
  void initState() {
    if (widget.controller != null) {
      textEditingController = widget.controller!;
    } else {
      textEditingController = TextEditingController();
    }
    textEditingController.addListener(_hasTextListener);

    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      textEditingController.dispose();
    }
    textEditingController.removeListener(_hasTextListener);

    super.dispose();
  }

  void _hasTextListener() {
    return setState(() {
      hasText = textEditingController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: TextField(
        controller: textEditingController,
        onChanged: (str) {
          setState(() {
            hasText = str.isNotEmpty;
          });
          widget.onChanged?.call(str);
        },
        style: widget.textStyle,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.autocorrect,
        autofocus: widget.autoFocus,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        textCapitalization: widget.textCapitalization,
        showCursor: true,
        scrollPhysics: const BouncingScrollPhysics(),
        onSubmitted: (text) {
          widget.onSubmit?.call(text);
        },
        textInputAction: widget.textInputAction,
        decoration: _buildInputDecoration(context),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
        labelText: widget.hintText,
        filled: true,
        helperText: (widget.helperText.isNotEmpty)
            ? widget.helperText
            : (helpText != null && helpText!.isNotEmpty)
                ? helpText
                : null,
        prefixIcon: widget.prefixIcon,
        isDense: ResponsiveValue(context, defaultValue: true, valueWhen: [
          const Condition.largerThan(name: PHONE, value: false)
        ]).value,
        suffixIcon: hasText
            ? IconButton(
                tooltip: "Limpiar el texto: ${textEditingController.text}",
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _clearText();
                },
              )
            : widget.suffixIconWhenNoText,
        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 9),
        focusedBorder: widget.outlineInputBorder ??
            OutlineInputBorder(
                borderRadius: widget.borderRadius,
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2)),
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide.none,
        ));
  }

  void _clearText() {
    textEditingController.clear();
    if (widget.focusNode != null) {
      widget.focusNode!.unfocus();
    }
    widget.onChanged?.call("");
    widget.onSubmit?.call("");
  }
}
