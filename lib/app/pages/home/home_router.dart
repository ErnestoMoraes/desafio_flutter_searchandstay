import 'package:desafio_flutter_searchandstay/app/pages/home/home_controller.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_page.dart';
import 'package:desafio_flutter_searchandstay/app/repositories/rules/rules_repository.dart';
import 'package:desafio_flutter_searchandstay/app/repositories/rules/rules_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();
  static Widget get page => MultiProvider(
        providers: [
          Provider<RulesRepository>(
            create: (context) => RulesRepositoryImpl(
              dio: context.read(),
            ),
          ),
          Provider(
            create: (context) => HomeController(
              context.read(),
            ),
          ),
        ],
        child: const HomePage(),
      );
}
