import 'package:flutter/material.dart';
import 'package:padelgo/constants/colors.dart';
import 'package:padelgo/ui/base/base_dash_line.dart';
import 'package:padelgo/ui/base/base_icon_button.dart';

class BaseExpand extends StatefulWidget {
  final Widget? tile;
  final Widget child;
  final Widget? icon;
  final String? iconText;
  final TextStyle? iconTextStyle;
  final Function(bool)? onExpansionChanged;

  const BaseExpand(
      {super.key,
      this.tile,
      required this.child,
      this.icon,
      this.iconText,
      this.iconTextStyle,
      this.onExpansionChanged});

  @override
  State<BaseExpand> createState() => _BaseExpandState();
}

class _BaseExpandState extends State<BaseExpand> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _height;
  bool _expanded = false;

  void _updateExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_expanded);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _height = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (widget.tile != null)
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(right: 22),
                  child: widget.tile ?? Container()),
            ),
          GestureDetector(
              onTap: _updateExpanded,
              behavior: HitTestBehavior.opaque,
              child: Row(children: [
                Text(widget.iconText ?? '',
                    style: widget.iconTextStyle ??
                        const TextStyle(
                            color: BaseColors.black100,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                AnimatedRotation(
                    turns: _expanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: BaseIconButton(
                        onPressed: _updateExpanded,
                        icon: widget.icon ??
                            const Icon(
                              Icons.expand_more_rounded,
                              size: 24,
                            )))
              ]))
        ]),
        AnimatedBuilder(
            animation: _height,
            builder: (context, child) => ClipRect(
                child: Align(heightFactor: _height.value, child: child)),
            child: Padding(
                padding: const EdgeInsets.only(top: 16), child: widget.child))
      ]);
}

class SecondaryExpand extends StatefulWidget {
  final Widget child;
  final String? title;
  final bool canExpanded;
  final Function(bool)? onExpansionChanged;

  const SecondaryExpand({
    super.key,
    required this.child,
    this.title,
    this.canExpanded = true,
    this.onExpansionChanged,
  });

  @override
  State<SecondaryExpand> createState() => _SecondaryExpandState();
}

class _SecondaryExpandState extends State<SecondaryExpand>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _height;
  bool _expanded = false;

  void _updateExpanded() {
    if (!widget.canExpanded) return;

    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_expanded);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _height = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (!widget.canExpanded) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: widget.canExpanded
            ? BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xFFDEDFE8)),
                borderRadius: const BorderRadius.all(Radius.circular(12)))
            : const BoxDecoration(
                color: BaseColors.blue220,
                borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _updateExpanded,
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Container(
                    height: 46,
                    width: 4,
                    color: widget.canExpanded
                        ? BaseColors.black100
                        : BaseColors.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.title ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 12),
                  if (widget.canExpanded)
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.expand_more_rounded, size: 24),
                    ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizeTransition(
              sizeFactor: _height,
              axisAlignment: -1,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: widget.child,
                ),
                const SizedBox(height: 12),
              ]),
            ),
          ],
        ),
      );
}

class BillExpand extends StatefulWidget {
  final Widget child;
  final Widget title;
  final Widget? subTitle;
  final String actionValue;
  final bool canExpanded;
  final Function(bool)? onExpansionChanged;

  const BillExpand({
    super.key,
    required this.child,
    required this.title,
    required this.actionValue,
    this.subTitle,
    this.canExpanded = true,
    this.onExpansionChanged,
  });

  @override
  State<BillExpand> createState() => _BillExpandState();
}

class _BillExpandState extends State<BillExpand> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _height;
  bool _expanded = false;

  void _updateExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_expanded);
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _height = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: widget.canExpanded
            ? BoxDecoration(
                border: Border.all(width: 1, color: const Color(0xFFDEDFE8)),
                borderRadius: const BorderRadius.all(Radius.circular(12)))
            : const BoxDecoration(
                color: BaseColors.blue220,
                borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: widget.title),
                const SizedBox(width: 12),
                if (widget.canExpanded)
                  GestureDetector(
                    onTap: _updateExpanded,
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Text(widget.actionValue,
                            style: const TextStyle(
                                color: BaseColors.black100,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        AnimatedRotation(
                          turns: _expanded ? 0.5 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child:
                              const Icon(Icons.expand_more_rounded, size: 24),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            if (widget.subTitle != null) ...[
              const SizedBox(height: 12),
              widget.subTitle ?? Container(),
            ],
            const SizedBox(height: 16),
            SizeTransition(
              sizeFactor: _height,
              axisAlignment: -1,
              child: Column(children: [
                const HorizontalDashedLine(
                  color: Color(0xFFB9B9B9),
                ),
                const SizedBox(height: 16),
                widget.child,
                const SizedBox(height: 16),
              ]),
            ),
          ],
        ),
      );
}
