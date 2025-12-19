import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/ui/base/keyboard_dismissible_wrapper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/constants/icon.dart';
import 'package:padelgo/generated/locale_keys.g.dart';
import 'package:padelgo/ui/base/base_button.dart';

class BaseSelectionListDialog extends StatefulWidget {
  final List<String> options;
  final String title;
  final String? selectedValue;
  final String confirmText;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double itemHeight;

  const BaseSelectionListDialog({
    super.key,
    required this.options,
    required this.title,
    this.selectedValue,
    this.confirmText = 'Konfirmasi',
    this.selectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.itemHeight = 60.0,
  });

  @override
  State<BaseSelectionListDialog> createState() =>
      _BaseSelectionListDialogState();
}

class _BaseSelectionListDialogState extends State<BaseSelectionListDialog> {
  late String? _selectedValue;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
    _scrollController = ScrollController();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToSelectedValue());
  }

  void _scrollToSelectedValue() {
    if (!_scrollController.hasClients) return;
    final selectedIndex = widget.options.indexOf(_selectedValue ?? '');
    if (selectedIndex == -1) return;
    final containerHeight = widget.options.length > 5
        ? 5 * widget.itemHeight
        : widget.options.length * widget.itemHeight;
    final itemTopOffset = selectedIndex * widget.itemHeight;
    double desiredOffset =
        itemTopOffset - (containerHeight / 2) + (widget.itemHeight / 2);
    if (desiredOffset < 0) desiredOffset = 0;
    if (_scrollController.position.maxScrollExtent > 0 &&
        desiredOffset > _scrollController.position.maxScrollExtent) {
      desiredOffset = _scrollController.position.maxScrollExtent;
    }
    if (desiredOffset > 0 && _scrollController.position.maxScrollExtent > 0) {
      _scrollController.animateTo(
        desiredOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxDialogHeight = screenHeight * 0.65;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: maxDialogHeight,
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      'assets/icons/svg/close.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (context, index) {
                  final option = widget.options[index];
                  final isSelected = _selectedValue == option;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? (widget.selectedColor ??
                                    const Color(0xFFE3F0FF))
                                : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              title: Center(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontWeight:
                                        isSelected ? FontWeight.bold : null,
                                    fontSize: isSelected ? 16 : 14,
                                    color: isSelected
                                        ? (widget.selectedTextColor ??
                                            const Color(0xFF4285F4))
                                        : (widget.unselectedTextColor ??
                                            Colors.black87),
                                  ),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedValue = option;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      if (isSelected)
                        const Positioned(
                          right: 2,
                          top: -2,
                          child: Icon(
                            Icons.check_circle,
                            color: BaseColors.primaryColor,
                            size: 24,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: BaseColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                onPressed: _selectedValue != null
                    ? () => Navigator.pop(context, _selectedValue)
                    : null,
                child: Text(widget.confirmText),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Future<String?> showBaseSelectionDialog(BuildContext context,
    {required List<String> options,
    required String title,
    String? selectedValue,
    String? confirmText,
    bool withPadding = false}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    enableDrag: false,
    builder: (context) => WillPopScope(
      onWillPop: () async => false,
      child: Padding(
        padding: withPadding
            ? EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20 + MediaQuery.of(context).viewInsets.bottom)
            : const EdgeInsetsGeometry.all(0),
        child: BaseSelectionListDialog(
          options: options,
          title: title,
          selectedValue: selectedValue,
          confirmText: confirmText ?? LocaleKeys.confirm.tr(),
        ),
      ),
    ),
  );
}

class GenericDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final String? title;
  final Widget content;
  final bool hasNextButton;
  final VoidCallback? onNext;
  final bool isNextButtonEnabled;
  final String? nextButtonText;
  final EdgeInsetsGeometry? padding;
  final bool hasHeader;

  const GenericDialog(
      {super.key,
      this.onCancel,
      this.title,
      required this.content,
      this.hasNextButton = true,
      this.onNext,
      this.isNextButtonEnabled = true,
      this.nextButtonText,
      this.padding,
      this.hasHeader = true});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final maxDialogHeight = screenHeight * 0.65;

    return KeyboardDismissibleWrapper(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: maxDialogHeight,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: padding ??
            EdgeInsets.only(
                left: 20, top: hasHeader ? 20 : 30, right: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasHeader)
              Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 32, height: 32),
                        // Centered title
                        Expanded(
                          child: Text(
                            title ?? '',
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: BaseColors.black100),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Close button
                        GestureDetector(
                            onTap:
                                onCancel ?? () => Navigator.of(context).pop(),
                            child: Container(
                              width: 32,
                              height: 32,
                              padding: const EdgeInsets.all(4),
                              child: SvgPicture.asset(IconConstants.close),
                            ))
                      ])),
            Flexible(
              child: SingleChildScrollView(
                child: content,
              ),
            ),
            if (hasNextButton) ...[
              const SizedBox(height: 30),
              PrimaryButton(
                text: nextButtonText ?? 'Lanjut',
                onPressed: onNext,
                enabled: isNextButtonEnabled,
                width: double.infinity,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ConfirmDialog extends StatelessWidget {
  final String text;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String? buttonNegativeText;
  final String? buttonPositiveText;

  const ConfirmDialog(
      {super.key,
      required this.text,
      this.onCancel,
      this.onConfirm,
      this.buttonNegativeText,
      this.buttonPositiveText});

  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 40),
        Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: BaseColors.black100)),
        const SizedBox(height: 60),
        Row(children: [
          Expanded(
              child: BaseButton(
                  onPressed: onCancel ?? () => Navigator.of(context).pop(),
                  text: buttonNegativeText ?? LocaleKeys.no.tr(),
                  backgroundColor: BaseColors.primaryColor30)),
          const SizedBox(width: 10),
          Expanded(
              child: PrimaryButton(
                  onPressed: onConfirm,
                  text: buttonPositiveText ?? LocaleKeys.confirm.tr()))
        ])
      ]));
}

void showBaseDraggableDialog(
  BuildContext context, {
  required Widget Function(ScrollController) builder,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => PopScope(
          canPop: false,
          child: DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.65,
            maxChildSize: 0.65,
            shouldCloseOnMinExtent: false,
            builder: (context, scrollController) => Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20 + MediaQuery.of(context).viewInsets.bottom),
                child: builder(scrollController)),
          )));
}

void showBaseDialog(
  BuildContext context, {
  required Widget child,
}) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => PopScope(
            canPop: false,
            child: Padding(
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: 20 + MediaQuery.of(context).viewInsets.bottom),
                child: child),
          ));
}

void showGenericDialog(
  BuildContext context, {
  required String title,
  required Widget content,
  bool hasNextButton = true,
  VoidCallback? onNext,
  bool isNextButtonEnabled = true,
  String? nextButtonText,
}) {
  showBaseDialog(context,
      child: GenericDialog(
        title: title,
        content: content,
        hasNextButton: hasNextButton,
        onNext: onNext,
        isNextButtonEnabled: isNextButtonEnabled,
        nextButtonText: nextButtonText,
      ));
}
