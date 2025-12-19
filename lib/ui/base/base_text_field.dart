import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:padelgo/constants/icon.dart';
import 'package:padelgo/generated/locale_keys.g.dart';

class BaseTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final bool showError;
  final String? errorText;
  final bool autoValidate;
  final FocusNode? focusNode;

  const BaseTextField({
    super.key,
    this.label,
    this.hintText,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius = 20,
    this.showError = true,
    this.errorText,
    this.autoValidate = false,
    this.focusNode,
  });

  @override
  State<BaseTextField> createState() => BaseTextFieldState();
}

class BaseTextFieldState extends State<BaseTextField> {
  final _focusNode = FocusNode();
  late TextEditingController _controller;
  String? _errorText;
  bool _hasBeenTouched = false;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      if (_focusNode.hasFocus) {
        _focusNode.unfocus();
      }
      _focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    } else {
      _controller.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.autoValidate && _hasBeenTouched) {
      _validate();
    }
    widget.onChanged?.call(_controller.text);
  }

  void _validate() {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(_controller.text);
      });
    }
  }

  void validate() {
    _hasBeenTouched = true;
    _validate();
  }

  bool get isValid {
    if (widget.validator == null) return true;
    return widget.validator!(_controller.text) == null;
  }

  String get text => _controller.text;

  void clear() {
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final displayError = widget.errorText ?? _errorText;
    final hasError = displayError != null && widget.showError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: _controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          focusNode: widget.focusNode ?? _focusNode,
          validator: widget.validator,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
            ),
            labelText: widget.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError
                    ? (widget.errorBorderColor ?? Colors.red)
                    : const Color(0xFFF5F5F5),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError
                    ? (widget.errorBorderColor ?? Colors.red)
                    : const Color(0xFFF5F5F5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: hasError
                    ? (widget.errorBorderColor ?? Colors.red)
                    : (widget.focusedBorderColor ?? Colors.blue),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: widget.errorBorderColor ?? Colors.red,
                width: 1,
              ),
            ),
            fillColor: widget.fillColor ?? Colors.white,
            filled: true,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmitted,
          onChanged: (value) {
            if (!_hasBeenTouched) {
              _hasBeenTouched = true;
            }
            widget.onChanged?.call(value);
          },
        ),

        // Error text
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            displayError,
            style: TextStyle(
              fontSize: 12,
              color: widget.errorBorderColor ?? Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}

class BaseSelectionField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? value;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final bool showError;
  final String? errorText;
  final EdgeInsetsGeometry? contentPadding;

  const BaseSelectionField({
    super.key,
    this.label,
    this.hintText,
    this.value,
    this.onTap,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius = 20,
    this.showError = true,
    this.errorText,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && showError;
    final displayText = value ?? '';
    final isPlaceholder = value == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: TextEditingController(text: displayText),
          readOnly: true,
          onTap: onTap,
          style: TextStyle(
            fontSize: 16,
            color: isPlaceholder ? const Color(0xFF999999) : Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 16,
            ),
            labelText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: hasError
                    ? (errorBorderColor ?? Colors.red)
                    : const Color(0xFFF5F5F5),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: hasError
                    ? (errorBorderColor ?? Colors.red)
                    : const Color(0xFFF5F5F5),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: hasError
                    ? (errorBorderColor ?? Colors.red)
                    : (focusedBorderColor ?? Colors.blue),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorBorderColor ?? Colors.red,
                width: 1,
              ),
            ),
            fillColor: fillColor ?? Colors.white,
            filled: true,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
            suffixIcon: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey[600],
              size: 24,
            ),
            counterText: '',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        // Error text
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: TextStyle(
              fontSize: 12,
              color: errorBorderColor ?? Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}

class BankTextField extends StatefulWidget {
  final void Function()? onTap;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const BankTextField({super.key, this.onTap, this.controller, this.onChanged});

  @override
  State<BankTextField> createState() => BankTextFieldState();
}

class BankTextFieldState extends State<BankTextField> {
  final _key = GlobalKey<BaseTextFieldState>();

  bool get isValid => _key.currentState?.isValid ?? false;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.bank_empty.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => BaseTextField(
      key: _key,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: _validator,
      label: LocaleKeys.bank.tr(),
      hintText: LocaleKeys.bank_hint.tr(),
      readOnly: true,
      suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0), // atur padding agar pas
          child: Image.asset(IconConstants.arrowNext, width: 20, height: 20)));
}

class BankAccountNumberTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const BankAccountNumberTextField(
      {super.key, this.controller, this.onChanged});

  @override
  State<BankAccountNumberTextField> createState() =>
      BankAccountNumberTextFieldState();
}

class BankAccountNumberTextFieldState
    extends State<BankAccountNumberTextField> {
  final _key = GlobalKey<BaseTextFieldState>();

  bool get isValid => _key.currentState?.isValid ?? false;

  void _onChanged(String value) {
    _key.currentState?.validate();

    widget.onChanged?.call(value);
  }

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.account_number_empty.tr();
    }
    if (value.length < 6) return LocaleKeys.account_number_length.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) => BaseTextField(
      key: _key,
      onChanged: _onChanged,
      controller: widget.controller,
      validator: _validator,
      label: LocaleKeys.account_number.tr(),
      hintText: LocaleKeys.account_number_hint.tr(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 16,
      autoValidate: true);
}
