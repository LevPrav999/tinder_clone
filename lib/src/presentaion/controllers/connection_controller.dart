import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tinder_clone/src/presentaion/states/user_state.dart';

enum ConnectivityStatus { notDetermined, isConnected, isDisonnected}


final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier(ref: ref);
});

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus?> {
  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;

  Ref ref;

  ConnectivityStatusNotifier({required this.ref}) : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.notDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){
        newState = ConnectivityStatus.isConnected;
      }
      if(result == ConnectivityResult.none){
        newState = ConnectivityStatus.isDisonnected;
      }


      if (newState != lastResult) {
        if(lastResult != ConnectivityStatus.notDetermined){
          ref.read(connectionStateProvider.notifier).update((state) => true);
        }
        state = newState!;
        lastResult = newState;
      }
    });
  }
}