import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  // all of the method would be here
  Future<void> createCategory(Category category);
  Future<List<Category>> getCategory();
}
