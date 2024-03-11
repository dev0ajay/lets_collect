part of 'redemption_history_bloc.dart';

@immutable
abstract class RedemptionHistoryState extends Equatable{
  const RedemptionHistoryState();
}

class RedemptionHistoryInitial extends RedemptionHistoryState {
  @override

  List<Object?> get props => [];
}

class RedemptionHistoryLoading extends RedemptionHistoryState {
  @override

  List<Object?> get props => [];
}

class RedemptionHistoryLoaded extends RedemptionHistoryState {
  final RedemptionHistoryResponse redemptionHistoryResponse;
  const RedemptionHistoryLoaded({required this.redemptionHistoryResponse});
  @override
  List<Object?> get props => [redemptionHistoryResponse];
}

class RedemptionHistoryErrorState extends RedemptionHistoryState {
  final String errorMsg;
  const RedemptionHistoryErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
