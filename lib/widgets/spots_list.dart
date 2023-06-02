import 'package:fav_spots/models/spot.dart';
import 'package:fav_spots/screens/spot_detail_screen.dart';
import 'package:flutter/material.dart';

class SpotsList extends StatelessWidget {
  const SpotsList({super.key, required this.spots});

  final List<Spot> spots;

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) {
      return Center(
        child: Text(
          'No spotes added yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    //TODO change item design  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: spots.length,
        itemBuilder: (ctx, index) => ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(spots[index].image),
          ),
          title: Text(
            spots[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SpotDetailScreen(spot: spots[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
