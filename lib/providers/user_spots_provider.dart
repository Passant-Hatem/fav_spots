import 'dart:io';

import 'package:fav_spots/models/spot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/spot_location.dart';

class UserSpotsNotifier extends StateNotifier<List<Spot>> {
  UserSpotsNotifier() : super(const []);

  void addSpot(String title, File image, SpotLocation spotLocation) {
    final newSpot = Spot(
      title: title,
      image: image,
      location: spotLocation
    );
    state = [newSpot, ...state];
  }
}

final userSpotsProvider = StateNotifierProvider<UserSpotsNotifier, List<Spot>>(
  (ref) => UserSpotsNotifier(),
);
