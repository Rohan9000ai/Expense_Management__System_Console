Expense Manager

A simple console-based Expense Manager built with Dart using Object-Oriented Programming (OOP).

This project allows users to manage their income and expenses, track budgets, search and remove transactions, organize expenses by category, and save data using files and JSON.

Features
Add income transactions
Add expense transactions
Assign expense categories
Select transaction methods
Give each transaction a unique ID
View transaction history
Search transactions by ID
Remove transactions
Calculate total income
Calculate total expenses
Calculate remaining balance
Set and track a monthly budget
Check remaining budget
Generate a financial report
Track expenses by category
Save data to files
Load saved data when the program starts
JSON-based data storage
Technologies Used
Dart
Object-Oriented Programming
Abstract classes
Inheritance
Method overriding
Enums
Lists
File handling
JSON
async / await
Project Structure
expense_manager/
│
├── bin/
│   └── main.dart
│
├── lib/
│   ├── models/
│   │   ├── transaction.dart
│   │   ├── income.dart
│   │   ├── expense.dart
│   │   └── budget.dart
│   │
│   ├── services/
│   │   └── expense_manager.dart
│   │
│   └── enums/
│       ├── expense_category.dart
│       └── transaction_type.dart
│
├── trans.txt
├── transactions.txt
├── category.txt
├── README.md
└── pubspec.yaml
OOP Structure

The project uses an abstract parent class:

abstract class Transction

Income and Expense inherit from it:

Transction
   │
   ├── Income
   │
   └── Expense

The project also contains a separate Budget class for budget calculations.

ExpenseManager controls the main application logic such as:

adding transactions
calculating totals
searching
removing transactions
generating reports
managing stored data
Transaction Categories

Expenses can be assigned to:

food
education
shopping
health
others
Transaction Methods

The project supports:

cash
online
banktransfer
others
Data Storage

The project uses three files:

trans.txt

Stores transaction history.

Example:

12|income|you added rs.90000.0...
15|expense|you spend rs.5000.0...

The | separator makes it easier to search and remove transactions.

transactions.txt

Stores summary information as JSON.

Example:

{
  "Budget": 50000,
  "Total Income": 90000,
  "Total Expense": 15000
}
category.txt

Stores expense totals by category using JSON.

Example:

{
  "food": 5000,
  "education": 3000,
  "shopping": 7000
}
How to Run

Make sure Dart is installed.

Clone the repository:

git clone YOUR_GITHUB_REPOSITORY_URL

Go into the project directory:

cd expense_manager

Run the application:

dart run
Main Menu

The program provides the following options:

1. Add transaction
2. Remove transaction
3. View transactions
4. Search transactions
5. Calculate income
6. Calculate expenses
7. Calculate balance
8. Generate report
9. Exit
Example

A user can add an income:

Enter the amount: 90000
Enter one transaction method: online
Enter unique id to store transaction: 12

The program stores the transaction and updates the total income.

An expense can then be added:

Enter the amount: 5000
Enter the category: food
Enter one transaction method: cash
Enter unique id to store transaction: 13

The expense is stored and the food category total is updated.

What I Learned From This Project

This project was built to practice:

Classes and objects
Constructors
Abstract classes
Inheritance
Method overriding
Enums
Object state
File handling
JSON encoding and decoding
Asynchronous programming
Separating application logic into different classes
Building a complete console application
Future Improvements

Possible improvements for future versions:

Better input validation
Better exception handling
Proper DateTime based monthly filtering
More advanced reports
Export reports to CSV
Better separation between storage and business logic
Recalculate category totals after deleting transactions
Graphical user interface
Database storage
Author
Rohan ud din 

Built as a Dart OOP practice project and designed as a real-world expense management application.