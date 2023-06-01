import 'package:flutter/material.dart';

import '../models/spot.dart';

class SpotDetailScreen extends StatelessWidget {
  const SpotDetailScreen({super.key, required this.spot});

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(spot.title),
      ),
      body: Center(
        child: Text(
          spot.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
