import 'dart:convert';
import 'dart:io';
import 'package:dart_application_1/enums/expense_category.dart';
import 'package:dart_application_1/enums/transaction_type.dart';
import 'package:dart_application_1/models/budget.dart';
import 'package:dart_application_1/models/expense.dart';
import 'package:dart_application_1/models/income.dart';
// TRANSACTION HISTORY
Future<void> history(String id, String type, String desc,) async {
  final transFile = File('trans.txt');
  try 
  {
    await transFile.writeAsString("$id|$type|$desc\n", mode: FileMode.append,);
    print("Transaction saved successfully.");
  } 
  catch (e) 
  {
    print("Write failed: $e");
  }
}
// CLEAN TRANSACTION FILE
Future<void> clean() async 
{
  final cleanFile = File('trans.txt');
  await cleanFile.writeAsString('', mode: FileMode.write,);
}
// VIEW TRANSACTIONS
Future<void> view() async 
{
  final viewFile = File('trans.txt');
  if (!await viewFile.exists()) 
  {
    print("No transaction history found.");
    return;
  }
  List<String> lines = await viewFile.readAsLines();
  if (lines.isEmpty) 
  {
    print("No transactions found.");
    return;
  }
  print("\n========== TRANSACTION HISTORY ==========");
  for (var line in lines) {
    if (line.trim().isNotEmpty) {
      print(line);
    }
  }
  print("=========================================");
}

// READ TRANSACTION FOR REMOVAL
Future<List<List<String>>> read(String id) async 
{
  final readFile = File('trans.txt');
  if (!await readFile.exists()) 
  {
    print("Transaction file does not exist.");
    return [];
  }
  List<String> lines = await readFile.readAsLines();
  List<List<String>> splitLines = lines.where((line) => line.trim().isNotEmpty).map((line) => line.split('|')).toList();
  int lengthBefore = splitLines.length;
  splitLines.removeWhere((line) => line.isNotEmpty && line[0] == id,);
  if (splitLines.length < lengthBefore) 
  {
    print("Transaction $id has been successfully removed.");
  } 
  else 
  {
    print("ID not found.");
  }
  return splitLines;
}

// SEARCH TRANSACTION
Future<void> serch(String id) async 
{
  final searchFile = File('trans.txt');
  if (!await searchFile.exists()) 
  {
    print("Transaction file does not exist.");
    return;
  }
  List<String> lines = await searchFile.readAsLines();
  bool found = false;
  for (String line in lines) 
  {
    if (line.trim().isEmpty) 
    {
      continue;
    }
    List<String> parts = line.split('|');
    if (parts.isNotEmpty && parts[0] == id) 
    {
      print("\nTransaction found:");
      print(line);
      found = true;
    }
  }
  if (!found) 
  {
    print("ID not found.");
  }
}

// SAVE REPORT

Future<void> report(double budget, double totalIncome, double totalExpense,) async {
  final reportFile = File('transactions.txt');
  Map<String, double> contents = 
  {'Budget': budget, 'Total Income': totalIncome, 'Total Expense': totalExpense, };
  await reportFile.writeAsString(jsonEncode(contents),mode: FileMode.write,);
}
// READ BUDGET / INCOME FROM JSON

Future<double> getreadbudget(String keyvalue) async 
{
  final file = File('transactions.txt');
  if (!await file.exists()) 
  {
    return 0.0;
  }
  String content = await file.readAsString();
  if (content.trim().isEmpty) 
  {
    return 0.0;
  }
  try 
  {
    Map<String, dynamic> data = jsonDecode(content) as Map<String, dynamic>;
    return (data[keyvalue] as num?)?.toDouble() ?? 0.0;
  } 
  catch (e) 
  {
    print("Error reading budget: $e");
    return 0.0;
  }
}

Future<double> getincomevalue(String keyvalue) async 
{
  final file = File('transactions.txt');
  if (!await file.exists()) 
  {
    return 0.0;
  }
  String content = await file.readAsString();

  if (content.trim().isEmpty) 
  {
    return 0.0;
  }

  try 
  {
    Map<String, dynamic> data = jsonDecode(content) as Map<String, dynamic>;
    return (data[keyvalue] as num?)?.toDouble() ?? 0.0;
  } 
  catch (e) 
  {
    print("Error reading income: $e");
    return 0.0;
  }
}

// READ EXPENSE FROM JSON

Future<double> getexpensevalue(String keyvalue) async 
{
  final file = File('transactions.txt');
  if (!await file.exists()) 
  {
    return 0.0;
  }
  String content = await file.readAsString();
  if (content.trim().isEmpty) 
  {
    return 0.0;
  }
  try 
  {
    Map<String, dynamic> data = jsonDecode(content) as Map<String, dynamic>;
    return (data[keyvalue] as num?)?.toDouble() ?? 0.0;
  } 
  catch (e) 
  {
    print("Error reading expense: $e");
    return 0.0;
  }
}

// CATEGORY
Future<void> category(String key, double value,) async {
  final categoryFile = File('category.txt');
  Map<String, dynamic> data = {};
  if (await categoryFile.exists()) 
  {
    String lines = await categoryFile.readAsString();
    if (lines.trim().isNotEmpty) 
    {
      try 
      {
        data = jsonDecode(lines) as Map<String, dynamic>;
      } 
      catch (e) 
      {
        print("Category file error: $e");
      }
    }
  }
  double currentAmount =  (data[key] as num?)?.toDouble() ?? 0.0;
  data[key] = currentAmount + value;
  await categoryFile.writeAsString( jsonEncode(data), mode: FileMode.write,);
}

// GET CATEGORIES
Future<void> getcategories() async 
{
  final catFile = File('category.txt');
  if (!await catFile.exists()) 
  {
    print("No category data found.");
    return;
  }
  String line = await catFile.readAsString();
  if (line.trim().isEmpty) 
  {
    print("No category data found.");
    return;
  }
  try 
  {
    Map<String, dynamic> data =  jsonDecode(line) as Map<String, dynamic>;
    print("\n========== CATEGORIES ==========");
    data.forEach((key, value) 
    {
      print("$key : $value");
    });
    print("================================");
  } 
  catch (e) 
  {
    print("Error reading categories: $e");
  }
}
// EXPENSE MANAGER

class ExpenseManager 
{
  double totalincomeamount = 0.0;
  double totalamountexp = 0.0;
  double budget = 0.0;

  // INITIALIZE DATA
  Future<void> init() async 
  {
    totalincomeamount =  await getincomevalue("Total Income");
    totalamountexp =  await getexpensevalue("Total Expense");
    budget =  await getreadbudget("Budget");
    if (budget <= 0) 
    {
      getbudgetvalue();
    }
  }
  // GET BUDGET

  void getbudgetvalue() 
  {
    while (true) 
    {
      stdout.write("Enter the Budget: ");
      String? input = stdin.readLineSync();
      double? value = double.tryParse(input ?? '');
      if (value != null && value > 0) 
      {
        budget = value;
        break;
      }
      print("Please enter a valid positive number.");
    }
  }

  // ADD TRANSACTION

  Future<void> addtransaction() async 
  {
    print("\n1. Enter income transaction" "\n2. Enter expense transaction", );
    stdout.write("Enter your choice: ");
    int? num = int.tryParse(stdin.readLineSync() ?? '',);
    if (num == 1) {
      Transctions tra = Transctions.others;
      stdout.write("Enter the title of transaction: ");
      String title = stdin.readLineSync() ?? '';
      stdout.write("Enter the amount: ");
      double? incomeamount = double.tryParse(stdin.readLineSync() ?? '',);
      if (incomeamount == null || incomeamount <= 0) 
      {
        print("Amount must be greater than 0.");
        return;
      }
      String datetime = DateTime.now().toString();
      print("cash, online, banktransfer, others",);
      stdout.write("Enter one transaction method: ",);
      String transaction =  (stdin.readLineSync() ?? '').toLowerCase();
      if (transaction == "cash") 
      {
        tra = Transctions.cash;
      } 
      else if (transaction == "online") 
      {
        tra = Transctions.online;
      } 
      else if (transaction == "banktransfer") 
      {
        tra = Transctions.banktransfer;
      }
      stdout.write("Enter unique id to store transaction: ",);
      String id = stdin.readLineSync() ?? '';
      if (id.trim().isEmpty) 
      {
        print("ID cannot be empty.");
        return;
      }
      Income income = Income(title,totalincomeamount,incomeamount,datetime,tra,);
      // Save history
      await history(id, "income", income.describtion(),);
      totalincomeamount = income.adding();
      await report(budget, totalincomeamount, totalamountexp, );
      print("Income added successfully.");
    }
    else if (num == 2) 
    {
      Category catexp = Category.others;
      Transctions traexp = Transctions.others;
      stdout.write("Enter the title of transaction: ");
      String titleexp = stdin.readLineSync() ?? '';
      stdout.write("Enter the amount: ");
      double? amountexp = double.tryParse(stdin.readLineSync() ?? '',);
      if (amountexp == null || amountexp <= 0) 
      {
        print("Amount must be greater than 0.");
        return;
      }
      String datetimeexp = DateTime.now().toString();
      print("food, education, shopping, health, others",);
      stdout.write("Enter the category: ");
      String categoryexp = (stdin.readLineSync() ?? '').toLowerCase();
      if (categoryexp == "food") 
      {
        catexp = Category.food;
      }
      else if (categoryexp == "education") 
      {
        catexp = Category.education;
      } 
      else if (categoryexp == "shopping") 
      {
        catexp = Category.shopping;
      } 
      else if (categoryexp == "health") 
      {
        catexp = Category.health;
      }
      print("cash, online, banktransfer, others",);
      stdout.write("Enter one transaction method: ",);
      String transactionexp =  (stdin.readLineSync() ?? '').toLowerCase();
      if (transactionexp == "cash") 
      {
        traexp = Transctions.cash;
      } 
      else if (transactionexp == "online") 
      {
        traexp = Transctions.online;
      } 
      else if (transactionexp == "banktransfer") 
      {
        traexp = Transctions.banktransfer;
      }
      Expense exp = Expense(titleexp, totalamountexp, amountexp, datetimeexp, catexp, traexp, );
      stdout.write("Enter unique id to store transaction: ",);
      String ide = stdin.readLineSync() ?? '';
      if (ide.trim().isEmpty) 
      {
        print("ID cannot be empty.");
        return;
      }
      // Save history
      await history(ide, "expense", exp.describtion(), );
      totalamountexp = exp.adding();
      await category(categoryexp, amountexp,);
      await report(budget,totalincomeamount,totalamountexp,);
      print("Expense added successfully.");
    }
    else 
    {
      print("Invalid choice.");
    }
  }

  Future<void> removetransction(String removeid,) async {
    List<List<String>> newdata =  await read(removeid);
    await clean();
    for (List<String> d in newdata) 
    {
      if (d.length >= 3) 
      {
        await history(d[0],d[1],d[2],);
      }
    }
    await init();
  }

  Future<void> viewtransactions() async 
  {
    await view();
  }

  Future<void> serchtransction() async 
  {
    stdout.write("Enter id to search transaction: ",);
    String id = stdin.readLineSync() ?? '';
    await serch(id);
  }

  double calculateincome() 
  {
    if (totalincomeamount > 0) 
    {
      return totalincomeamount;
    }
    return 0.0;
  }

  double calculateexpense() 
  {
    if (totalamountexp > 0) 
    {
      return totalamountexp;
    }
    return 0.0;
  }

  double budgeting() 
  {
    Budget g = Budget(totalamountexp, budget, );
    return g.remainings();
  }

  Future<void> generatereport() async 
  {
    print("=================== REPORT ===================",);
    print("Budget: $budget");
    print("Total Income: $totalincomeamount");
    print("Total Expense: $totalamountexp");
    print("Remaining Balance: ${totalincomeamount - totalamountexp}",);
    print("Remaining Budget: ${budgeting()}",);
    await getcategories();
    print("===============================================",);
  }
}