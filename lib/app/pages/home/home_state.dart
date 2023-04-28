// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:desafio_flutter_searchandstay/app/models/rule_model.dart';

part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<RuleModel> rules;
  final String? errorMessage;

  const HomeState({
    required this.status,
    required this.rules,
    required this.errorMessage,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        errorMessage = null,
        rules = const [];

  @override
  List<Object?> get props => [status, rules, errorMessage];

  HomeState copyWith({
    HomeStateStatus? status,
    List<RuleModel>? rules,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      rules: rules ?? this.rules,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
