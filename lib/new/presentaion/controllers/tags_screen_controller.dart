import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/user_service.dart';

import '../screens/home_screen.dart';

final tagsProvider = AsyncNotifierProvider<TagsScreenNotifier, String>(TagsScreenNotifier.new);

class TagsScreenNotifier extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    return "";
  }

  Future<void> uploadTags(List<dynamic> tags, BuildContext context) async{
    state = const AsyncLoading();
    var result = await ref.read(userServiceProvider).setUserTags(tags);

    result.fold((left){
      state = AsyncValue.data(left.message);
    }, (right){
      state = AsyncValue.data("");
      Navigator.pushNamed(context, HomeScreen.routeName);
    });
  }
}