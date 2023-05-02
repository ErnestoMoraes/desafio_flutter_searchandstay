import 'dart:developer';
import 'package:desafio_flutter_searchandstay/app/core/exceptions/repository_exception.dart';
import 'package:desafio_flutter_searchandstay/app/core/rest_client/custom_dio.dart';
import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  CustomDio dio = CustomDio();
  const id = 590;
  setUp(() {
    dio = CustomDio();
  });

  group('Teste Endpoint: ', () {
    test('GET /house_rules', () async {
      try {
        final result = await dio.auth().get('/house_rules');
        expect(result.statusCode, 200);
        final response = result.data['data']['entities'];
        final rules =
            response.map<RuleModel>((r) => RuleModel.fromMap(r)).toList();
        expect(rules.isNotEmpty, true);
      } catch (e, s) {
        log('Error Fetching All Rule', error: e, stackTrace: s);
        throw RepositoryException(message: 'Error Fetching All Rule');
      }
    });

    test('GET-Especific /house_rules', () async {
      try {
        final result = await dio.auth().get('/house_rules/$id');
        expect(result.statusCode, 200);
        final rule = result.data['data'];
        expect(rule.isNotEmpty, true);
      } catch (e, s) {
        log('Error Fetching Rule', error: e, stackTrace: s);
        throw RepositoryException(message: 'Error Fetching Rule');
      }
    });

    test('POST /house_rules', () async {
      try {
        final result = await dio.auth().post('/house_rules', data: {
          "house_rules": {
            "name": "Teste 001",
            "active": 1,
          }
        });
        expect(result.statusCode, 200);
        final rule = result.data['data'];
        expect(rule.isNotEmpty, true);
      } catch (e, s) {
        log('Error creating new rule', error: e, stackTrace: s);
        throw RepositoryException(message: 'Error creating new rule');
      }
    });

    test('PUT /house_rules', () async {
      Map<String, dynamic> data = {
        "house_rules": {
          "name": "Update holiday new - Ernesto",
          "active": 0,
        }
      };
      try {
        final result = await dio.auth().put('/house_rules/$id', data: data);
        expect(result.statusCode, 200);
        final rule = result.data['data'];
        expect(rule.isNotEmpty, true);
      } catch (e, s) {
        log('Error updating rule', error: e, stackTrace: s);
        throw RepositoryException(message: 'Error updating rule');
      }
    });

    //! Endpoint DELETE está funcionando - só não vou deletar os dados do banco
    //! test('DELETE /house_rules', () async {
    //!   try {
    //!     final result = await dio.auth().delete('/house_rules/$id');
    //!     expect(result.statusCode, 200);
    //!     final rule = result.data['data'];
    //!     expect(rule.isNotEmpty, true);
    //!   } catch (e, s) {
    //!     log('Erro ao criar nova atividades', error: e, stackTrace: s);
    //!     throw RepositoryException(message: 'Erro ao criar nova atividades');
    //!   }
    //! });
  });
}
