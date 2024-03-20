import 'package:uuid/uuid.dart';

const uuid = Uuid();

class FavoritePlace {
  final String id;
  final String title;

  FavoritePlace({required this.title}) : id = uuid.v4();
}
