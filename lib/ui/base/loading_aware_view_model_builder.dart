import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:padelgo/ui/base/loading_state_manager.dart';
import 'package:padelgo/ui/helpers/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:padelgo/ui/extension/build_context_extension.dart';

class LoadingAwareViewModelBuilder<T extends LoadingAwareViewModel>
    extends StatefulWidget {
  final Widget Function(BuildContext context, T viewModel, Widget? child)
      builder;
  final T Function() viewModelBuilder;
  final void Function(T)? onViewModelReady;
  final bool reactive;
  final bool createNewViewModelOnInsert;
  final void Function(T)? onDispose;
  final Widget? child;

  const LoadingAwareViewModelBuilder({
    super.key,
    required this.builder,
    required this.viewModelBuilder,
    this.onViewModelReady,
    this.reactive = true,
    this.createNewViewModelOnInsert = true,
    this.onDispose,
    this.child,
  });

  @override
  _LoadingAwareViewModelBuilderState<T> createState() =>
      _LoadingAwareViewModelBuilderState<T>();
}

class _LoadingAwareViewModelBuilderState<T extends LoadingAwareViewModel>
    extends State<LoadingAwareViewModelBuilder<T>> {
  late T _viewModel;
  bool _hasShownInitialLoading = false;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModelBuilder();
    LoadingStateManager().addListener(_handleBusyStateChange);

    if (_viewModel.isBusy) {
      _hasShownInitialLoading = true;
      scheduleMicrotask(() {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _viewModel.isBusy) {
              context.showLoading();
            }
          });
        }
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasShownInitialLoading && _viewModel.isBusy) {
      _hasShownInitialLoading = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _viewModel.isBusy) {
          context.showLoading();
        }
      });
    }
  }

  @override
  void dispose() {
    LoadingStateManager().removeListener(_handleBusyStateChange);
    if (widget.onDispose != null) {
      widget.onDispose!(_viewModel);
    }
    super.dispose();
  }

  void _handleBusyStateChange(bool isBusy) {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (isBusy) {
          context.showLoading();
        } else {
          context.hideLoading();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>.nonReactive(
      viewModelBuilder: () => _viewModel,
      builder: (context, model, child) {
        return PopScope(
          canPop: !model.isBusy,
          onPopInvoked: (didPop) async {
            if (!didPop && model.isBusy) {
              HapticFeedback.heavyImpact();
            }
          },
          child: ListenableBuilder(
            listenable: model,
            builder: (context, child) {
              return widget.builder(context, model, widget.child);
            },
            child: widget.child,
          ),
        );
      },
      onViewModelReady: (model) {
        if (widget.onViewModelReady != null) {
          widget.onViewModelReady!(_viewModel);
        }
      },
      onDispose: (model) {
        if (LoadingOverlay.instance.isVisible) {
          LoadingOverlay.instance.hide();
        }
        if (widget.onDispose != null) {
          widget.onDispose!(model);
        }
      },
    );
  }
}
