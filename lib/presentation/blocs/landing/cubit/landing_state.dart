part of 'landing_cubit.dart';

abstract class LandingState extends Equatable {
  const LandingState();

  @override
  List<Object> get props => [];
}

class LandingInitial extends LandingState {}

class TabChangesIndexState extends LandingState {
  int bottomTabIndex = 0;
  TabChangesIndexState({required this.bottomTabIndex});
}
