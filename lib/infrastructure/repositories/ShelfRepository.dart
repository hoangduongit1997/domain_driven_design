import 'package:domain_driven_design/domain/entities/BookShelf.dart';
import 'package:domain_driven_design/domain/repositories/IBookShelfRepository.dart';
import 'package:domain_driven_design/domain/value_objects/Identity.dart';
import 'package:domain_driven_design/infrastructure/datasources/IDatasource.dart';
import 'package:domain_driven_design/infrastructure/models/BookModel.dart';
import 'package:domain_driven_design/infrastructure/models/ShelfModel.dart';

class ShelfRepository implements IBookShelfRepository {
  IDatasource _datasource;

  ShelfRepository(this._datasource);

  @override
  create(BookShelf bookShelf) async {
    var shelModel = ShelfModel(id: bookShelf.id);
    return await _datasource.createShelf(shelModel);
  }

  @override
  Future<BookShelf> find(Identity shelfId) async {
    ShelfModel shelf = await _datasource.findShelf(shelfId);
    List<BookModel> books = [];
    if (shelf != null) books = await _datasource.findBooksOnSelf(shelfId);

    BookShelf bookShelf = BookShelf(id: shelfId);
    books.forEach((b) => bookShelf.addBook(b));
    return bookShelf;
  }
}
