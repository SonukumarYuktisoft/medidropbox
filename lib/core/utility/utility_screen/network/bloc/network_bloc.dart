import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription<InternetConnectionStatus>? _connectionSubscription;
  final InternetConnectionChecker _connectionChecker;

  NetworkBloc({InternetConnectionChecker? connectionChecker})
      : _connectionChecker = connectionChecker ?? InternetConnectionChecker.instance,
        super(const NetworkState()) {
    on<NetworkObserve>(_onNetworkObserve);
    on<NetworkStatusChanged>(_onNetworkStatusChanged);
    on<CheckNetworkStatus>(_onCheckNetworkStatus);
  }

  void _onNetworkObserve(
    NetworkObserve event,
    Emitter<NetworkState> emit,
  ) {
    _connectionSubscription?.cancel();
    
    _connectionSubscription = _connectionChecker.onStatusChange.listen(
      (status) {
        final isConnected = status == InternetConnectionStatus.connected;
        add(NetworkStatusChanged(isConnected));
      },
    );
  }

  void _onNetworkStatusChanged(
    NetworkStatusChanged event,
    Emitter<NetworkState> emit,
  ) {
    emit(state.copyWith(
      isConnected: event.isConnected,
      status: event.isConnected 
          ? NetworkStatus.connected 
          : NetworkStatus.disconnected,
    ));
  }

  Future<void> _onCheckNetworkStatus(
    CheckNetworkStatus event,
    Emitter<NetworkState> emit,
  ) async {
    try {
      final hasConnection = await _connectionChecker.hasConnection;
      emit(state.copyWith(
        isConnected: hasConnection,
        status: hasConnection 
            ? NetworkStatus.connected 
            : NetworkStatus.disconnected,
      ));
    } catch (e) {
      emit(state.copyWith(
        isConnected: false,
        status: NetworkStatus.disconnected,
      ));
    }
  }

  @override
  Future<void> close() {
    _connectionSubscription?.cancel();
    return super.close();
  }
}