import 'dart:io';
import 'package:dart_application_1/services/expense_manager.dart';

Future<void> main() async 
{
  ExpenseManager expensemanager = ExpenseManager();
  await expensemanager.init();
  while (true) 
  {
    print("\n===== EXPENSE MANAGER =====");
    print(
      "1. Add transaction\n"
      "2. Remove transaction\n"
      "3. View transactions\n"
      "4. Search transactions\n"
      "5. Calculate income\n"
      "6. Calculate expenses\n"
      "7. Calculate balance\n"
      "8. Generate report\n"
      "9. Exit",
    );
    stdout.write("Enter your choice: ");
    String choice = stdin.readLineSync() ?? '';
    switch (choice) 
    {
      case "1":
        await expensemanager.addtransaction();
        break;

      case "2":
        stdout.write("Enter the id to remove that transaction: ",);
        String id = stdin.readLineSync() ?? '';
        await expensemanager.removetransction(id);
        break;

      case "3":
        await expensemanager.viewtransactions();
        break;

      case "4":
        await expensemanager.serchtransction();
        break;

      case "5":
        print("Total income: ${expensemanager.calculateincome()}");
        break;

      case "6":
        print("Total expenses: ${expensemanager.calculateexpense()}",);
        break;

      case "7":
        print("Remaining budget: ${expensemanager.budgeting()}",);
        print("Account balance: ${expensemanager.totalincomeamount -expensemanager.totalamountexp}",);
        break;

      case "8":
        await expensemanager.generatereport();
        break;

      case "9":
        print("Exiting the program....");
        return;

      default:
        print("Invalid choice.");
    }
  }
}