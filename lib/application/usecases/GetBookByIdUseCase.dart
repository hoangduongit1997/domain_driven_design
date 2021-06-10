import 'package:dartz/dartz.dart';
import 'package:domain_driven_design/application/boundaries/get_all_books/BookDto.dart';
import 'package:domain_driven_design/application/boundaries/get_book_by_id/GetBookByIdInput.dart';
import 'package:domain_driven_design/application/boundaries/get_book_by_id/GetBookByIdOuput.dart';
import 'package:domain_driven_design/application/boundaries/get_book_by_id/IGetBookByIdUseCase.dart';
import 'package:domain_driven_design/domain/repositories/IBookRepository.dart';
import 'package:domain_driven_design/domain/value_objects/Failure.dart';

class GetBookByIdUseCase implements IGetBookByIdUseCase {
  final IBookRepository _bookRepository;

  GetBookByIdUseCase({IBookRepository bookRepository})
      : _bookRepository = bookRepository;
  @override
  Future<Either<Failure, GetBookByIdOutput>> execute(
      GetBookByIdInput input) async {
    var book = await _bookRepository.find(bookId: input.bookId);

    if (book == null) return Left(Failure('Book not found'));

    return Right(GetBookByIdOutput(book: BookDto.fromEntity(book)));
  }
}
