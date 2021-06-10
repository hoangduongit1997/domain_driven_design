import 'package:flutter/foundation.dart';
import 'package:domain_driven_design/domain/entities/Book.dart';
import 'package:domain_driven_design/domain/entities/BookShelf.dart';
import 'package:domain_driven_design/domain/value_objects/Author.dart';
import 'package:domain_driven_design/domain/value_objects/ISBN.dart';
import 'package:domain_driven_design/domain/value_objects/PublishDate.dart';
import 'package:domain_driven_design/domain/value_objects/Title.dart';

abstract class IEntityFactory {
  Book newBook({
    @required Title title,
    @required Author author,
    @required ISBN isbn,
    @required PublishDate publishDate,
  });

  BookShelf newBookShelf();
}
