# Point of Sale (POS) System 🛍️

[![GitHub Stars](https://img.shields.io/github/stars/Hailemariyam/pos_system?style=social)](https://github.com/Hailemariyam/pos_system) 
[![GitHub Forks](https://img.shields.io/github/forks/Hailemariyam/pos_system?style=social)](https://github.com/Hailemariyam/pos_system)
[![License](https://img.shields.io/github/license/Hailemariyam/pos_system)](https://github.com/Hailemariyam/pos_system/blob/main/LICENSE)

## Overview 🚀

The **Point of Sale (POS) System** is a **mobile** and **desktop** solution developed using **Flutter** to help businesses process sales transactions quickly and efficiently. It streamlines sales, inventory management, and reporting, enabling businesses to better manage customer purchases and track performance.

With support for **multi-platforms**, this app enables seamless use across both mobile and desktop systems. 

## Features 🎉

- **User Roles**: Cashier, Manager, and Admin with customizable permissions.
- **Sales Processing**: Effortless product addition, discount application, and payment processing.
- **Inventory Management**: Track, add, and remove products, view stock levels in real-time.
- **Reports**: Generate detailed sales, performance, and inventory reports.
- **Authentication**: Secure login authentication.

## Technologies Used 💻

- **Flutter** & **Dart**: For building cross-platform mobile and desktop apps.
- **HiveDB**: Lightweight database for local storage management.
- **SharedPreferences**: For storing app settings and preferences.
- **Bloc & Hydrated Bloc**: To manage state and persist data across app restarts.
- **Git/GitHub**: For version control and project collaboration.

## Installation Instructions 🔧

Follow these steps to set up the project locally:

### 1. Clone the Repository
```bash
git clone https://github.com/Hailemariyam/pos_system.git
cd pos_system
flutter pub get
## Run the App
### For Mobile:
flutter run
### For Desktop (Windows, macOS, Linux)
flutter run -d windows   # For Windows
flutter run -d macos     # For macOS
flutter run -d linux     # For Linux

## User Roles & Stories 📋
### 1. Cashier
Login: Login with username/password or biometric authentication.
Sales Processing: Add/remove items, apply discounts, and complete payments.
Transaction History: View all completed sales transactions.
### 2. Manager
View Reports: Access detailed sales and inventory reports.
Employee Metrics: Track cashier performance, manage refunds.
Inventory Management: View and adjust stock levels.
### 3. Admin
System Configuration: Set up taxes, payment methods, and other system-wide settings.
User Management: Add, remove, or edit user roles (Cashiers, Managers).
Product Management: Manage products and inventory settings.


Screenshots 📱💻


How to Contribute 🤝
We welcome contributions! If you’d like to contribute to this project, follow these steps:

Fork the repository.
Create a new branch.
Make your changes and commit them.
Push the changes to your fork.
Open a pull request.
Please make sure your code adheres to the project’s style guide and includes tests for new features.
