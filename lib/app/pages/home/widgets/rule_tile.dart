// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:desafio_flutter_searchandstay/app/core/ui/base_state/base_state.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/helpers/size_extensions.dart';
import 'package:desafio_flutter_searchandstay/app/core/ui/styles/colors_app.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_controller.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RuleTile extends StatefulWidget {
  final RuleModel rule;

  const RuleTile({
    Key? key,
    required this.rule,
  }) : super(key: key);

  @override
  State<RuleTile> createState() => _RuleTileState();
}

class _RuleTileState extends BaseState<RuleTile, HomeController> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeController, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Slidable(
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: ((context) {
                  print('clicou em editar');
                  var newRulw = RuleModel(
                    id: widget.rule.id,
                    name: widget.rule.name,
                    active: widget.rule.active == 0 ? 1 : 0,
                    order: 0,
                  );
                  context.read<HomeController>().editarRule(newRulw);
                }),
                backgroundColor:
                    widget.rule.active == 0 ? Colors.grey : Colors.green,
                icon: widget.rule.active == 0
                    ? Icons.check_box_outline_blank
                    : Icons.check_box,
              ),
              SlidableAction(
                onPressed: ((context) {
                  print('clicou em apagar');
                  context
                      .read<HomeController>()
                      .apagarRule(widget.rule.id)
                      .then(
                          (value) => showInfo('Atividade apagada com sucesso'))
                      .catchError(
                          (error) => showError('Erro ao apagar atividade'));
                }),
                backgroundColor: Colors.red,
                icon: Icons.delete,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              print('clicou');
            },
            child: SizedBox(
              height: context.percentWidth(.12),
              child: ListTile(
                leading: Icon(
                  Icons.rule,
                  color: context.colorsApp.cardgrey,
                ),
                trailing: Icon(
                  widget.rule.active == 0
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  color: context.colorsApp.cardgrey,
                ),
                title: Text(
                  widget.rule.name,
                  style: TextStyle(
                    color: context.colorsApp.cardgrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
