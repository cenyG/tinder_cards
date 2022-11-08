import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tinder_cards/widgets/icon_button.dart';

class ActionButtonsBar extends StatelessWidget {
  final void Function()? onBack;
  final void Function()? onDiss;
  final void Function()? onSuper;
  final void Function()? onLike;
  final void Function()? onBoost;

  const ActionButtonsBar({
    Key? key,
    this.onBack,
    this.onDiss,
    this.onSuper,
    this.onLike,
    this.onBoost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const iconSmall = 28.0;
    const iconBig = 38.0;

    final _onBack = onBack != null ? onBack! : () => log('back');
    final _onDiss = onBack != null ? onDiss! : () => log('diss');
    final _onSuper = onBack != null ? onSuper! : () => log('super');
    final _onLike = onLike != null ? onLike! : () => log('like');
    final _onBoost = onBoost != null ? onBoost! : () => log('boost');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedIconButton(
          icon: Icons.undo_rounded,
          size: iconSmall,
          color: Colors.amberAccent.shade400,
          onTap: _onBack,
        ),
        RoundedIconButton(
          padding: 8,
          icon: Icons.close_rounded,
          size: iconBig,
          color: Colors.red.shade400,
          onTap: _onDiss,
        ),
        RoundedIconButton(
          icon: Icons.star,
          size: iconSmall,
          color: Colors.blue.shade400,
          onTap: _onSuper,
        ),
        RoundedIconButton(
          padding: 8,
          icon: Icons.favorite,
          size: iconBig,
          color: Colors.green.shade400,
          onTap: _onLike,
        ),
        RoundedIconButton(
          icon: Icons.bolt,
          size: iconSmall,
          color: Colors.deepPurple.shade400,
          onTap: _onBoost,
        ),
      ].map((w) => Expanded(child: w)).toList(),
    );
  }
}
