import 'package:dartz/dartz.dart';
import 'package:domain_driven_design/application/boundaries/add_book/AddBookInput.dart';
import 'package:domain_driven_design/application/boundaries/add_book/AddBookOutput.dart';
import 'package:domain_driven_design/application/boundaries/add_book/IAddBookUseCase.dart';
import 'package:domain_driven_design/domain/DomainExcpetion.dart';
import 'package:domain_driven_design/domain/entities/Book.dart';
import 'package:domain_driven_design/domain/entities/BookShelf.dart';
import 'package:domain_driven_design/domain/factories/IEntityFactory.dart';
import 'package:domain_driven_design/domain/repositories/IBookRepository.dart';
import 'package:domain_driven_design/domain/repositories/IBookShelfRepository.dart';
import 'package:domain_driven_design/domain/value_objects/Failure.dart';
import 'package:domain_driven_design/domain/value_objects/Identity.dart';

class AddBookUseCase implements IAddBookUseCase {
  final IBookShelfRepository _bookShelfRepository;
  final IBookRepository _bookRepository;
  final IEntityFactory _entityFactory;

  const AddBookUseCase(
      {IBookShelfRepository bookShelfRepository,
      IBookRepository bookRepository,
      IEntityFactory entityFactory})
      : _bookShelfRepository = bookShelfRepository,
        _bookRepository = bookRepository,
        _entityFactory = entityFactory;

  @override
  Future<Either<Failure, AddBookOutput>> execute(AddBookInput input) async {
    Book newBook = _createBookFromInput(input);

    Either<Failure, BookShelf> result =
        await _addBookToShelf(newBook, input.shelfId);
    if (result.isLeft()) return result.fold((err) => Left(err), (_) => null);

    var bookshelf = result.getOrElse(null);

    await _bookRepository.add(newBook);
    return _buildOutputFromNewBook(newBook, bookshelf);
  }

  Either<Failure, AddBookOutput> _buildOutputFromNewBook(
      Book newBook, BookShelf bookShelf) {
    var output = AddBookOutput(
        bookId: newBook.id,
        shelfId: bookShelf.id,
        title: newBook.title,
        author: newBook.author,
        isbn: newBook.isbn,
        publishDate: newBook.publishDate);

    return Right(output);
  }

  Future<Either<Failure, BookShelf>> _addBookToShelf(
      Book newBook, Identity shelfId) async {
    BookShelf bookShelf = await _bookShelfRepository.find(shelfId);
    if (bookShelf == null) return Left(Failure('book shelf not found'));
    try {
      bookShelf.addBook(newBook);
    } on DomainException {
      return Left(Failure('book shelf has reached its maximum capacity'));
    }

    return Right(bookShelf);
  }

  Book _createBookFromInput(AddBookInput input) {
    return _entityFactory.newBook(
        title: input.title,
        author: input.author,
        isbn: input.isbn,
        publishDate: input.publishDate);
  }
}
