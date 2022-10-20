import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {

  final Widget child;

  const ProfileCard(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: child,
    );
  }
}