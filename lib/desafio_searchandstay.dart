import 'package:desafio_flutter_searchandstay/app/core/provider/application_binding.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/theme/theme_config.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_router.dart';
import 'package:desafio_flutter_searchandstay/app/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class DesafioSearchandstay extends StatelessWidget {
  const DesafioSearchandstay({super.key});

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Desafio Searchandstay',
        theme: ThemeConfig.theme,
        routes: {
          '/': (context) => const LoginPage(),
          '/home': (context) => HomeRouter.page,
        },
      ),
    );
  }
}
