import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/detail_place.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;
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
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => PlaceDetailScreen(place: places[index])));
        },
      ),
    );
  }
}
