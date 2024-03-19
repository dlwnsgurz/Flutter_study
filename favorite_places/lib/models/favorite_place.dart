import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoritePlace {
  final String id;
  final String name;

  FavoritePlace({required this.name}) : id = uuid.v4();
}
