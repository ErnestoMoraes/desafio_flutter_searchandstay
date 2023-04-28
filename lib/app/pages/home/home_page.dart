import 'package:desafio_flutter_searchandstay/app/core/ui/base_state/base_state.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/colors_app.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/text_styles.dart';
import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_controller.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_state.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/widgets/rule_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  final newRuleEC = TextEditingController();
  final searchEC = TextEditingController();
  @override
  void onReady() {
    controller.carregarRules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('New Rule'),
                    content: TextFormField(
                      controller: searchEC,
                      style: context.textStyles.texLabelH4.copyWith(
                        color: context.colorsApp.labelblack1,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Name of the rule',
                        hintStyle: context.textStyles.texLabelH4.copyWith(
                          color: context.colorsApp.labelblack1,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    actions: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                        child: TextButton(
                          onPressed: () {
                            searchEC.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Back',
                            style: context.textStyles.texLabelH4.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                        ),
                        child: TextButton(
                          onPressed: () {
                            var lancamento = searchEC.text.trim();
                            if (lancamento.isNotEmpty && lancamento != '') {
                              controller
                                  .criarNovoRule(searchEC.text)
                                  .then(
                                      (value) => showSucess('Atividade criada'))
                                  .catchError((error) =>
                                      showError('Erro ao criar atividade'));
                              searchEC.clear();
                              lancamento = '';
                              Navigator.of(context).pop();
                            } else {
                              showError('Campo vazio');
                            }
                          },
                          child: Text(
                            'Save',
                            style: context.textStyles.texLabelH4.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
          IconButton(
            onPressed: () async {
              int index = 519;
              await controller
                  .buscarRuleEspecifico(index)
                  .then((value) => showSucess('Atividade encontrada'))
                  .catchError((error) => showError('Erro ao buscar atividade'));
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            error: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro ao carregar as regras');
            },
          );
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.rules.length,
                  itemBuilder: (context, index) {
                    final rule = state.rules[index];
                    return Column(
                      children: [
                        RuleTile(
                          rule: rule,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
