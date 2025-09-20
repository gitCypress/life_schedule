import 'package:flutter/material.dart';
import 'package:life_schedule/mixins/navigable_screen_mixin.dart';
import 'package:life_schedule/models/navigation_entry.dart';

class ExpenseTrackingScreen extends StatelessWidget with NavigableScreenMixin{
  const ExpenseTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('这是记账页'));
  }

  @override
  NavigationEntry get navEntry => _ExpenseTrackingNavigationEntry();
}

class _ExpenseTrackingNavigationEntry implements NavigationEntry{
  @override
  IconData get icon => Icons.account_balance_wallet_outlined;

  @override
  String get label => '记账';

}
