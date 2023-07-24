import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/user_service.dart';
import 'package:tinder_clone/new/presentaion/controllers/match_screen_controller.dart';
import 'package:tinder_clone/new/presentaion/controllers/tabs/cards_tab_controller.dart';

import '../screens/home_screen.dart';

final tagsProvider = AutoDisposeAsyncNotifierProvider<TagsScreenNotifier, String>(TagsScreenNotifier.new);
 
class TagsScreenNotifier extends AutoDisposeAsyncNotifier<String> {
  ProviderSubscription? subscription = null;

  @override
  FutureOr<String> build() {
    return "";
  }
 
  Future<void> uploadTags(List<dynamic> tags, BuildContext context) async{
    state = const AsyncLoading();
    var result = await ref.read(userServiceProvider).setUserTags(tags);

    result.fold((left){
      state = AsyncValue.error(left.message, StackTrace.empty);
    }, (right){

      ref.read(matchProvider.notifier).setCards();
      ref.read(cardsTabProvider.notifier).setCards();

      state = const AsyncValue.data(""); // Сбрасываем состояние загрузки
      subscription!.close();
      Navigator.pushNamed(context, HomeScreen.routeName);
    });
  }

  void setSub(ProviderSubscription subscription){
    this.subscription = subscription;
  }
}