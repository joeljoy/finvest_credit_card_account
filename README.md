# Finvest Credit Card Account App

This is a Flutter application showcasing a credit card listing and transaction management interface as part of the Finvest assignment. The app is built using Clean Architecture and MVVM, with custom state management and reusable components.

## Features
- **Credit Card Listing Screen**: Displays connected credit card accounts, a graph of balances, and associated transactions.
- **Transaction Filter Screen** (Bonus): Paginated transaction list with filtering options.

## Screenshots

### Home Screen  
Displays the list of connected credit card accounts and a graph showing balances.  
![Home Screen](https://github.com/joeljoy/finvest_credit_card_account/blob/main/screenshots/home.png)

### Transaction List Screen  
Paginated transaction list with filtering options.  
![Transaction Screen](https://github.com/joeljoy/finvest_credit_card_account/blob/main/screenshots/transaction_list.png)
![Transaction Screen](https://github.com/joeljoy/finvest_credit_card_account/blob/main/screenshots/transaction_list1.png)

### Sort & Filter  
Allows users to sort and filter transactions.  
![Filter Screen](https://github.com/joeljoy/finvest_credit_card_account/blob/main/screenshots/transaction_filters_bottom_sheet.png)
![Filter Screen](https://github.com/joeljoy/finvest_credit_card_account/blob/main/screenshots/filters_applied.png)


## Getting Started

Follow the steps below to clone and run the project locally.

### Prerequisites
1. Install [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0.0 or later recommended).
2. Ensure you have a working emulator or a physical device connected.
3. Install an IDE like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio) with the Flutter plugin.

---

### Steps to Run

1. **App Setup**
   ```bash
   git clone https://github.com/joeljoy/finvest_credit_card_account.git
   cd finvest_credit_card_account
   flutter pub get
   flutter run
