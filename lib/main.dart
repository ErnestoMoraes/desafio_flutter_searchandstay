import 'package:desafio_flutter_searchandstay/app/core/config/env/env.dart';
import 'package:desafio_flutter_searchandstay/desafio_searchandstay.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.instance.load();
  runApp(const DesafioSearchandstay());
}
