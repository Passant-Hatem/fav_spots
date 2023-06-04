import 'package:fav_spots/screens/add_spot_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fav_spots/providers/user_spots_provider.dart';

import '../widgets/spots_list.dart';

class SpotsListScreen extends ConsumerStatefulWidget {
  const SpotsListScreen({super.key});

  @override
  ConsumerState<SpotsListScreen> createState() {
    return _SpotsListScreenState();
  }
}

class _SpotsListScreenState extends ConsumerState<SpotsListScreen> {
  late Future<void> _spotsList;

  @override
  void initState() {
    super.initState();
    _spotsList = ref.read(userSpotsProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: _spotsList,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : SpotsList(
                      spots: userSpots,
                    ),
        ),
      ),
    );
  }
}
