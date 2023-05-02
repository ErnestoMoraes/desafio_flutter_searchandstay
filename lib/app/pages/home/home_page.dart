import 'package:desafio_flutter_searchandstay/app/core/ui/base_state/base_state.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/helpers/size_extensions.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/colors_app.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/text_styles.dart';
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
        title: Text(
          'Rules',
          style: context.textStyles.textButtonLabel.copyWith(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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
                                  .then((value) => showSucess('Rule Created'))
                                  .catchError((error) =>
                                      showError('Error Creating Rule'));
                              searchEC.clear();
                              lancamento = '';
                              Navigator.of(context).pop();
                            } else {
                              showError('Empty Field');
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
              controller.carregarRules();
            },
            icon: const Icon(
              Icons.refresh,
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
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.screenWidth * .02),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: newRuleEC,
                          keyboardType: TextInputType.number,
                          style: TextStyles.instance.texLabelH4.copyWith(
                            color: ColorsApp.instance.labelblack1,
                            fontSize: 20,
                            fontWeight:
                                TextStyles.instance.textButtonLabel.fontWeight,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Search by ID',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: context.screenWidth * .01,
                      ),
                      SizedBox(
                        height: context.percentWidth(.15),
                        child: ElevatedButton(
                          onPressed: () async {
                            int index = int.parse(newRuleEC.text);
                            await controller
                                .buscarRuleEspecifico(index)
                                .then((value) => showSucess('Rule Found'))
                                .catchError(
                                    (error) => showError('Rule Not Found'));
                            newRuleEC.clear();
                          },
                          child: const Icon(Icons.search_rounded),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.rules.length,
                    itemBuilder: (context, index) {
                      final rule = state.rules[index];
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: context.screenWidth * .02,
                              right: context.screenWidth * .02,
                              top: context.screenWidth * .02,
                            ),
                            child: RuleTile(rule: rule),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
