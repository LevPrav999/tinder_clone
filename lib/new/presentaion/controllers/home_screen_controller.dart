import 'package:flutter_riverpod/flutter_riverpod.dart';

var homeControllerProvider = StateNotifierProvider<HomeController, int>(
    (ref) => HomeController());

class HomeController extends StateNotifier<int>{
  HomeController() : super(0);


  void updateState(int index){
    state = index;
  }
}