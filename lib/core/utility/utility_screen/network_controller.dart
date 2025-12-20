import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  StreamSubscription<InternetConnectionStatus>? _streamSubscription;

  RxBool isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkNetworkConnection();
  }

  void checkNetworkConnection() {
    _streamSubscription = InternetConnectionChecker.instance
        .onStatusChange
        .listen((status) {
      isOnline.value = status == InternetConnectionStatus.connected;
    });
  }
 void chackNetworkConnection(){
      _streamSubscription =InternetConnectionChecker.instance.onStatusChange.listen((event) {
        if(event==InternetConnectionStatus.connected){
          isOnline.value=true;
        }else{
           isOnline.value=false;
        }
      },);
   } 
  @override
  void onClose() {
    _streamSubscription?.cancel();
    super.onClose();
  }
}
