import 'package:domain_driven_design/domain/value_objects/Identity.dart';
import 'package:domain_driven_design/infrastructure/models/BookModel.dart';
import 'package:domain_driven_design/infrastructure/models/ShelfModel.dart';

abstract class IDatasource {
  addBook(BookModel model);
  Future<List<BookModel>> findAllBooks();
  Future<BookModel> findBook(Identity bookId);
  Future<void> createShelf(ShelfModel model);
  Future<ShelfModel> findShelf(Identity shelfId);
  Future<List<BookModel>> findBooksOnSelf(Identity shelfId);
}
