import 'package:domain_driven_design/presentation/models/Book.dart';

class BookShelf {
  final String id;
  List<Book> books = [];

  BookShelf(this.id);
}
