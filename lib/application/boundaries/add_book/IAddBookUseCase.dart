import 'package:domain_driven_design/application/boundaries/IUseCase.dart';
import 'package:domain_driven_design/application/boundaries/add_book/AddBookInput.dart';
import 'package:domain_driven_design/application/boundaries/add_book/AddBookOutput.dart';

abstract class IAddBookUseCase extends IUseCase<AddBookInput, AddBookOutput> {}
