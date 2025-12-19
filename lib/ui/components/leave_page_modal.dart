import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/generated/locale_keys.g.dart';
import 'package:padelgo/ui/base/base_dialog.dart';

class LeavePageModal extends StatefulWidget {
  final VoidCallback? onCancel;
  final String? text;

  const LeavePageModal({super.key, this.onCancel, this.text});

  @override
  State<LeavePageModal> createState() => _LeavePageModalState();
}

class _LeavePageModalState extends State<LeavePageModal> {
  @override
  Widget build(BuildContext context) => ConfirmDialog(
      onCancel: widget.onCancel,
      onConfirm: () => Navigator.of(context).pop(),
      text: widget.text ?? '',
      buttonNegativeText: LocaleKeys.confirm_cancel.tr(),
      buttonPositiveText: LocaleKeys.confirm_continue.tr());
}
