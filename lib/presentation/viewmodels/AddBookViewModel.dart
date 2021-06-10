import 'package:domain_driven_design/application/boundaries/add_book/AddBookInput.dart';
import 'package:domain_driven_design/application/boundaries/add_book/IAddBookUseCase.dart';
import 'package:domain_driven_design/domain/value_objects/Author.dart';
import 'package:domain_driven_design/domain/value_objects/ISBN.dart';
import 'package:domain_driven_design/domain/value_objects/Identity.dart';
import 'package:domain_driven_design/domain/value_objects/PublishDate.dart';
import 'package:domain_driven_design/domain/value_objects/Title.dart';
import 'package:domain_driven_design/presentation/models/Book.dart';

class AddBookViewModel {
  final IAddBookUseCase _addBookUseCase;
  List<String> _errMessages = [];
  Book _book;

  Book get book => _book;

  AddBookViewModel(this._addBookUseCase);

  Future<void> addBook(String title, String author, String isbn,
      String publishDate, String shelfId) async {
    _errMessages = [];
    Title vtitle = Title.create(title).fold((err) {
      _errMessages.add(err.message);
      return null;
    }, (val) => val);

    Author vauthor = Author.create(author).fold((err) {
      _errMessages.add(err.message);
      return null;
    }, (val) => val);

    ISBN visbn = ISBN.create(isbn).fold((err) {
      _errMessages.add(err.message);
      return null;
    }, (val) => val);

    PublishDate vpublishDate = PublishDate.create(publishDate).fold((err) {
      _errMessages.add(err.message);
      return null;
    }, (val) => val);

    Identity vshelfId = Identity.fromString(shelfId);

    if (_errMessages.isNotEmpty) throw Exception(_errMessages.join('\n'));

    var input = AddBookInput(
        shelfId: vshelfId,
        title: vtitle,
        author: vauthor,
        isbn: visbn,
        publishDate: vpublishDate);

    var result = await _addBookUseCase.execute(input);

    result.fold(
      (e) => throw Exception(e.message),
      (o) => _book = Book(
        id: o.bookId.id,
        title: o.title.value,
        author: o.author.value,
        isbn: o.isbn.value,
        publishDate: o.publishDate.toString(),
      ),
    );
  }
}
