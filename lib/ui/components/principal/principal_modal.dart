import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/generated/locale_keys.g.dart';
import 'package:padelgo/ui/base/base_dialog.dart';

class PrincipalModal extends StatefulWidget {
  const PrincipalModal({super.key});

  @override
  State<PrincipalModal> createState() => _PrincipalModalState();
}

class _PrincipalModalState extends State<PrincipalModal> {
  @override
  Widget build(BuildContext context) => GenericDialog(
      title: LocaleKeys.principal_loan.tr(),
      content: Text(LocaleKeys.principal_info.tr(),
          style: const TextStyle(fontSize: 14, color: BaseColors.grey100)),
      nextButtonText: 'OK',
      onNext: () {
        Navigator.of(context).pop();
      });
}
