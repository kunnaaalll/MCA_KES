import java.util.Scanner;

class AccountDetails {
    private int accountNumber;
    private String accountHolderName;
    public double balance;
    private String accountType;

    public void accountDetails() {
        accountNumber = 123456;
        accountHolderName = "Kunal Parmar";
        accountType = "Savings";
        balance = 10000.0;
    }

    public void displayAccountDetails() {
        System.out.println("Account Number: " + accountNumber);
        System.out.println("Account Holder Name: " + accountHolderName);
        System.out.println("Account Type: " + accountType);
        System.out.println("Balance: " + balance);
    }
}

class transaction extends AccountDetails {

    // int bal = balance;

    public void deposit(double amount) {
        if (amount > 0) {
            balance = balance + amount;
            System.out.println("Deposited: " + amount);
        } else {
            System.out.println("Deposit Not Successful.");
        }
    }

    public void withdraw(double amount) {
        // balance = 10000;
        if (amount > 0 && amount <= balance) {
            balance -= balance - amount;
            System.out.println("Withdrew: " + amount);
        } else {
            System.out.println("Insufficient balance.");
        }
    }

    public double displayBalance() {
        System.out.println("Current Balance: " + balance);
        return balance;
    }

}

class loan extends AccountDetails {
    public void applyForLoan(double loanAmount) {
        if (loanAmount > 0) {
            System.out.println("Loan of " + loanAmount + " applied successfully.");
        } else {
            return;
        }
    }
}

class Account {
    public static void main(String[] args) {
        AccountDetails d = new AccountDetails();
        d.accountDetails();

        Scanner sc = new Scanner(System.in);
        System.out.println(
                "Enter Your Choice: \n1.Account Details\n2. Transaction\n3. Balance\n4. Apply For Loan\n9.Exit\n");
        int choice = sc.nextInt();
        sc.nextLine();

        transaction t = new transaction();
        loan l = new loan();

        switch (choice) {
            case 1:
                d.displayAccountDetails();
                break;
            case 2:
                do {
                    System.out.println("1. Deposit\n2. Withdraw\n3. Exit");
                    System.out.print("Enter your choice: ");

                    int tChoice = sc.nextInt();
                    switch (tChoice) {

                        case 1:
                            System.out.print("Enter amount to deposit: ");
                            double depositAmount = sc.nextDouble();
                            t.deposit(depositAmount);
                            break;

                        case 2:
                            System.out.print("Enter amount to withdraw: ");
                            double withdrawAmount1 = sc.nextDouble();
                            t.withdraw(withdrawAmount1);
                            break;

                        case 3:
                            System.out.println("Exiting transaction menu.");
                            return;

                        default:
                            System.out.println("Invalid choice.");
                            break;
                    }
                    t.displayBalance();
                } while (true);

            case 3:
                t.displayBalance();
                break;
            case 4:
                System.out.print("Enter loan amount: ");
                double loanAmount = sc.nextDouble();
                l.applyForLoan(loanAmount);
                break;
            default:
                System.out.println("Thank You!");
        }

        sc.close();
    }
}
