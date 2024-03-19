import 'package:favorite_places/models/favorite_place.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<FavoritePlace> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(
        child: Text(
          "Add New Place!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        title: Text(places[index].name),
      ),
    );
  }
}
