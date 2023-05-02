// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:desafio_flutter_searchandstay/app/core/exceptions/repository_exception.dart';
import 'package:desafio_flutter_searchandstay/app/core/rest_client/custom_dio.dart';
import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';
import 'package:dio/dio.dart';

import './rules_repository.dart';

class RulesRepositoryImpl implements RulesRepository {
  final CustomDio dio;

  RulesRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<RuleModel>> findAllRules() async {
    try {
      final result = await dio.auth().get('/house_rules');
      final response = result.data['data']['entities'];
      final rules =
          response.map<RuleModel>((r) => RuleModel.fromMap(r)).toList();
      return rules;
    } on DioError catch (e, s) {
      log('Erro ao buscar regras', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar regras');
    }
  }

  @override
  Future<RuleModel> getRule(int id) async {
    try {
      final result = await dio.auth().get('/house_rules/$id');
      final response = result.data['data'];
      final rule = RuleModel.fromMap(response);
      return rule;
    } on DioError catch (e, s) {
      log('Error Fetching Rule: $id', error: e, stackTrace: s);
      throw RepositoryException(message: 'Error Fetching Rule: $id');
    }
  }

  @override
  Future<void> createRule(String rule) async {
    try {
      await dio.auth().post('/house_rules', data: {
        "house_rules": {
          "name": rule,
          "active": 1,
        }
      });
    } on DioError catch (e, s) {
      log('Erro ao criar regras', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao criar regras');
    }
  }

  @override
  Future<void> updateRule(RuleModel rule) async {
    Map<String, dynamic> data = {
      "house_rules": {
        "name": rule.name,
        "active": rule.active,
      }
    };
    try {
      await dio.auth().put('/house_rules/${rule.id}', data: data);
    } on DioError catch (e, s) {
      log('Erro ao modificar regra', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao modificar regra');
    }
  }

  @override
  Future<void> deleteRule(int id) async {
    try {
      await dio.auth().delete('/house_rules/$id');
    } on DioError catch (e, s) {
      log('Erro ao deletar regra', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar regra');
    }
  }
}
