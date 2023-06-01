import 'package:fav_spots/screens/add_spot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_spots/providers/user_spots_provider.dart';

import '../widgets/spots_list.dart';

class SpotsListScreen extends ConsumerWidget {
  const SpotsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userSpots = ref.watch(userSpotsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddNewSpotScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SpotsList(
        spots: userSpots,
      ),
    );
  }
}
