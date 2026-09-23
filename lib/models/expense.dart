import 'package:dart_application_1/models/transaction.dart';
import 'package:dart_application_1/enums/expense_category.dart';
import 'package:dart_application_1/enums/transaction_type.dart';

class Expense extends Transction 
{
  String message = "";
  double total = 0;
  double newb = 0;
  Expense(String title, this.total, double amount, String datetime, Category category, Transctions transctions,) 
  {
    this.title = title;
    this.amount = amount;
    this.datetime = datetime;
    this.category = category;
    this.transctions = transctions;
    if (amount <= 0) 
    {
      message = "The amount must be greater than 0";
      exception(message);
      return;
    } 
    else 
    {
      message = "We were processing your amount";
      exception(message);
    }
  }
  @override
  void exception(String message) 
  {
    print(message);
  }
  double adding() 
  {
    newb = total + amount;
    return newb;
  }
  @override
  void display() 
  {
    print("Your total expense is $newb");
  }
  String describtion() 
  {
    return "you spend rs.$amount for $category with method of $transctions at time $datetime";
  }
}