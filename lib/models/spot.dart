import 'dart:io';

import 'package:fav_spots/models/spot_location.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Spot {
  Spot({
    required this.title,
    required this.image,
    required this.location,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final SpotLocation location;
}
