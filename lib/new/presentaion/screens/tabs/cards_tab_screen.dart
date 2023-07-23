import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/widgets/cards_widget.dart';

class CardsTabScreen extends ConsumerWidget {
  const CardsTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CardsWidget(matchScreen: false);
  }
}