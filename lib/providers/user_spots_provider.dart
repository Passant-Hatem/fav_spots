import 'dart:io';

import 'package:fav_spots/models/spot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSpotsNotifier extends StateNotifier<List<Spot>> {
  UserSpotsNotifier() : super(const []);

  void addSpot(String title, File image) {
    final newSpot = Spot(
      title: title,
      image: image,
    );
    state = [newSpot, ...state];
  }
}

final userSpotsProvider = StateNotifierProvider<UserSpotsNotifier, List<Spot>>(
  (ref) => UserSpotsNotifier(),
);
