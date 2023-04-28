import 'package:desafio_flutter_searchandstay/app/core/rest_client/custom_dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testes de endpoints: ', () async {
    test('GET /rules', () async {
      final dio = CustomDio();
      final result = await dio.auth().get('/house_rules');
      expect(result.statusCode, 200);
    });
  });
}
