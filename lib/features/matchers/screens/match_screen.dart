import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/widgets/cards_widget.dart';

class MatchScreen extends ConsumerWidget {
  static const String routeName = '/match-screen';
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: SafeArea(child: CardsWidget(matchScreen: true)),);
  }
}

