// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';
import 'package:desafio_flutter_searchandstay/app/pages/home/home_state.dart';
import 'package:desafio_flutter_searchandstay/app/repositories/rules/rules_repository.dart';

class HomeController extends Cubit<HomeState> {
  final RulesRepository _repository;

  HomeController(
    this._repository,
  ) : super(const HomeState.initial());

  Future<void> carregarRules() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      final rules = await _repository.findAllRules();
      emit(state.copyWith(status: HomeStateStatus.loaded, rules: rules));
    } catch (e, s) {
      log('Erro ao carregar as regras', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao carregar as regras',
        ),
      );
    }
  }

  Future<void> apagarRule(int id) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _repository.deleteRule(id);
      final rules = state.rules.where((r) => r.id != id).toList();
      emit(state.copyWith(status: HomeStateStatus.loaded, rules: rules));
    } catch (e, s) {
      log('Erro ao apagar as regras', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao apagar as regras',
        ),
      );
    }
  }

  Future<void> editarRule(RuleModel rule) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _repository.updateRule(rule);
      final rules = state.rules.map((r) {
        if (r.id == rule.id) {
          return rule;
        }
        return r;
      }).toList();
      emit(state.copyWith(status: HomeStateStatus.loaded, rules: rules));
    } catch (e, s) {
      log('Erro ao editar as regras', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao editar as regras',
        ),
      );
    }
  }

  Future<void> criarNovoRule(String rule) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      await _repository.createRule(rule);
      final newRules = await _repository.findAllRules();
      emit(
        state.copyWith(status: HomeStateStatus.loaded, rules: newRules),
      );
    } catch (e, s) {
      log('Erro ao criar nova regra', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Erro ao criar nova regra',
        ),
      );
    }
  }

  Future<RuleModel> buscarRuleEspecifico(int id) async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 1));
      final rule = await _repository.getRule(id);
      emit(state.copyWith(status: HomeStateStatus.loaded, rules: [rule]));
      return rule;
    } catch (e, s) {
      log('Rule não encontrada', error: e, stackTrace: s);
      emit(
        state.copyWith(
          status: HomeStateStatus.error,
          errorMessage: 'Rule não encontrada',
          rules: [],
        ),
      );
      rethrow;
    }
  }
}
