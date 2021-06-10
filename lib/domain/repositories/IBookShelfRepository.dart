import 'package:domain_driven_design/domain/entities/BookShelf.dart';
import 'package:domain_driven_design/domain/value_objects/Identity.dart';

abstract class IBookShelfRepository {
  create(BookShelf bookShelf);
  Future<BookShelf> find(Identity shelfId);
}
