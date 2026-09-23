class Budget 
{
  double monthlybudget = 0;
  double remaining = 0;
  double exp = 0;
  Budget(double expense, this.monthlybudget) 
  {
    exp = expense;
    if (expense > monthlybudget) 
    {
      print("You have exceeded your budget by ${expense - monthlybudget},");
    } else {
      print("You are within your budget. You have ${monthlybudget - expense} remaining.",);
    }
  }
  double remainings() 
  {
    remaining = monthlybudget - exp;
    return remaining;
  }
}