part of 'network_bloc.dart';

class NetworkState extends Equatable {
  final bool isConnected;
  final NetworkStatus status;

  const NetworkState({
    this.isConnected = false,
    this.status = NetworkStatus.initial,
  });

  NetworkState copyWith({
    bool? isConnected,
    NetworkStatus? status,
  }) {
    return NetworkState(
      isConnected: isConnected ?? this.isConnected,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [isConnected, status];
}

enum NetworkStatus { initial, connected, disconnected }