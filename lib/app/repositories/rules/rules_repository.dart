import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';

abstract class RulesRepository {
  Future<List<RuleModel>> findAllRules();

  Future<RuleModel> getRule(int id);

  Future<void> createRule(String newRule);

  Future<void> updateRule(RuleModel rule);

  Future<void> deleteRule(int id);
}
