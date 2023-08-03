import 'package:app_cuida_pet/app/core/life_cycle/controller_life_cycle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class PageLifeCycleState<C extends ControllerLifeCycle,
    P extends StatefulWidget> extends State<P> {
  final controller = Modular.get<C>();
  Map<String, dynamic>? get params => null;

  @override
  void initState() {
    controller.onInit(params);
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => controller.onReady());

    super.initState();
  }
}
