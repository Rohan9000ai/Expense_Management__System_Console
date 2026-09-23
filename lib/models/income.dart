import 'package:dart_application_1/models/transaction.dart';
import 'package:dart_application_1/enums/transaction_type.dart';

class Income extends Transction 
{
  String message = "";
  double total;
  double newb = 0;
  Income(String title, this.total, double amount, String datetime, Transctions transctions,) 
  {
    this.transctions = transctions;
    this.title = title;
    this.amount = amount;
    this.datetime = datetime;
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
    print("Your amount after adding is $newb");
  }
  String describtion() {
    return "you added rs.$amount with method of $transctions at time $datetime";
  }
}