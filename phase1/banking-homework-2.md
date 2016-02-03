Banking Homework - Tuesday, Feb. 2
==================================

The problems are graduated; each one builds on the previous one.  
Write and test your code for each step, and don't move on to the next step
until you are satisfied that it works properly and you know why. 

Problem
-------
Joe has a bank account containing $250

Sally has a bank account containing $4,000

Implement the names as strings and the account balances as integers.

Step 1 
------
Write a Ruby program to deposit money in Sally's bank account:

1. output the beginning balance in Sally's account
2. add $200 to the balance
3. output the updated balance.

Submit this program as Banking-1.rb

Step 2 
------
Write a Ruby program to deposit money in Sally's bank account:

1.  output the beginning balance in Sally's account
2.  read in an amount from the user at the keyboard and add it to the balance
3.  output the updated balance.
4.  What if the user types in hotdog for the amount to be added?  Make the program handle such
input gracefully.

Submit this program as Banking-2.rb

Step 3
------
Let's make this more realistic.  Write a Ruby program that outputs Sally's bank account
as $4000.00, not as 4000

1.  implement this change by modifying the output only; don't modify the data type of the account 
balance, which should remain an integer.
2.  Extra challenge (optional):  output the balance with commas preceding every 3 digits, so that
Sally's balance is output as $4,000.00

Submit this program as Banking-3.rb

Step 4
------
Implement the bank accounts as key/value pairs (hashes) containing the account holder's name (key) and the amount in the account (value).  Create an array of hashes and add a few more accounts to your liking (e.g. Wanda, $2) to the array.
Write a Ruby program to mimic a bank teller:

1.  read in the account holder's name
2.  output account holder's name and the beginning balance in the account 
3.  read in an amount to be deposited
4.  output account holder's name and the updated balance
5.  What if the user enters a name that is not associated with an account?  Make the program handle this gracefully.
6.  
Submit this program as Banking-4.rb

Step 5
------
The accounts even in this rudimentary bank should be able to handle dollars and cents!  Implement the
account balances not as integers, but as numbers containing decimal places. 

1.  make all necessary changes to your program from Step 4.

Submit this program as Banking-5.rb

Step 6
------
In your program from Step 5, define a method named deposit.  This method:

  * accepts only one parameter, which is the amount to be deposited
  * adds the amount to be deposited to the account balance
  * and that's all it does.

Output the account holder's name and the updated balance in the main body of the program,
not in the deposit method.

1.  doing this will cause lots of problems...what are they, and why do they occur?

Write a couple of lines/paragraphs describing what's going wrong and the reasons for it (and, 
if possible, the solutions.)

Submit this explanation as Banking-6.md

Extra challenge (optional)
--------------------------
At the end of the fiscal year, even our bank must do some accounting.  
In your program from Step 5, add up the balances in all of the accounts, and output this sum.

Submit this program as Banking-7.rb
