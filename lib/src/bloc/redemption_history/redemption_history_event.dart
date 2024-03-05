part of 'redemption_history_bloc.dart';

@immutable
abstract class RedemptionHistoryEvent extends Equatable{
  const RedemptionHistoryEvent();
}

class GetRedemptionHistory extends RedemptionHistoryEvent{
  @override
  List<Object?> get props => [];

}