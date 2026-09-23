import 'package:dart_application_1/enums/expense_category.dart';
import 'package:dart_application_1/enums/transaction_type.dart';

abstract class Transction {
Category category = Category.others;
Transctions transctions = Transctions.others;
double amount = 0.0;
String title = '';
String datetime = '';

void display();
void exception(String message);
}