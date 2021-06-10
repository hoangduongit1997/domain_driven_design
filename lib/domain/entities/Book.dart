import 'package:domain_driven_design/domain/value_objects/Author.dart';
import 'package:domain_driven_design/domain/value_objects/ISBN.dart';
import 'package:domain_driven_design/domain/value_objects/Identity.dart';
import 'package:domain_driven_design/domain/value_objects/PublishDate.dart';
import 'package:domain_driven_design/domain/value_objects/Title.dart';

class Book {
  Identity id;
  Identity shelfId;
  Title title;
  Author author;
  ISBN isbn;
  PublishDate publishDate;

  Book({
    this.id,
    this.shelfId,
    this.title,
    this.author,
    this.isbn,
    this.publishDate,
  });
}
