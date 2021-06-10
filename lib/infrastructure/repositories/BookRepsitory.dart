import 'package:domain_driven_design/domain/entities/Book.dart';
import 'package:domain_driven_design/domain/repositories/IBookRepository.dart';
import 'package:domain_driven_design/domain/value_objects/Identity.dart';
import 'package:domain_driven_design/infrastructure/datasources/IDatasource.dart';
import 'package:domain_driven_design/infrastructure/models/BookModel.dart';

class BookRepository implements IBookRepository {
  IDatasource _datasource;

  BookRepository({IDatasource datasource}) : _datasource = datasource;

  @override
  add(Book book) async {
    var model = BookModel(
      id: book.id,
      shelfId: book.shelfId,
      title: book.title,
      author: book.author,
      isbn: book.isbn,
      publishDate: book.publishDate,
    );

    return await _datasource.addBook(model);
  }

  @override
  delete({Identity bookId}) {
    // TODO: implement delete
    return null;
  }

  @override
  Future<Book> find({Identity bookId}) async {
    return await _datasource.findBook(bookId);
  }

  @override
  Future<List<Book>> findAll() async {
    return await _datasource.findAllBooks();
  }

  @override
  update(Book book) {
    // TODO: implement update
    return null;
  }
}
