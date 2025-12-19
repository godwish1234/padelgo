import 'package:flutter/material.dart';
import 'package:padelgo/constants/icon.dart';
import 'package:padelgo/enums/alert.dart';

class BaseAlert extends StatefulWidget {
  final String text;
  final Alert type;

  const BaseAlert(this.text, {super.key, required this.type});

  @override
  State<BaseAlert> createState() => _BaseAlertState();
}

class _BaseAlertState extends State<BaseAlert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Alert.getBackgroundColor(widget.type.id),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.center, // biar teks bisa turun rapi
        children: [
          Image.asset(
            IconConstants.alert,
            width: 20,
            height: 20,
            color: Alert.getColor(widget.type.id),
          ),
          const SizedBox(width: 8),
          Expanded(
            // ✅ ini penting biar teks bisa turun
            child: Text(
              widget.text,
              style: TextStyle(
                color: Alert.getColor(widget.type.id),
                fontSize: 12,
              ),
              softWrap: true, // ✅ memastikan text wrap
              overflow: TextOverflow.visible, // biar nggak dipotong
            ),
          ),
        ],
      ),
    );
  }
}
