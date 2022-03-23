import 'package:flutter/material.dart';
import 'package:imgur/app/locator.dart';
import 'package:imgur/data/controllers/state_controller.dart';
import 'package:provider/provider.dart';

class BaseView<T extends StateController> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;

  const BaseView({Key? key, required this.builder, this.onModelReady})
      : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends StateController> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
    // return ChangeNotifierProvider<T>(
    //     create: (context) => model,
    //     child: Consumer<T>(builder: widget.builder));
  }
}
