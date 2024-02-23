class RobotState {
  final RState state;
  RobotState({
    required this.state,
  });

  factory RobotState.fromString(String str) {
    if (str == 'interacting') {
      return RobotState(state: RState.interacting);
    } else {
      return RobotState(state: RState.idle);
    }
  }

  @override
  String toString() => 'RobotState(state: $state)';

  RobotState copyWith({
    RState? state,
  }) {
    return RobotState(
      state: state ?? this.state,
    );
  }
}

enum RState {
  idle,
  interacting,
}

extension RSX on RState {
  bool get isIdle => this == RState.idle;
  bool get isInteracting => this == RState.interacting;
}
