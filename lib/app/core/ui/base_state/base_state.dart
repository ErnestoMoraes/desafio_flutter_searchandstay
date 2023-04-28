import 'package:bloc/bloc.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/helpers/loader.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/helpers/messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Messages {
  late final C controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onReady();
    });
  }

  void onReady() {}
}
