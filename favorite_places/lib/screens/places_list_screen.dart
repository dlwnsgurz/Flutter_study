import 'package:favorite_places/models/favorite_place.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Places"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const PlacesList(places: []),
    );
  }
}
