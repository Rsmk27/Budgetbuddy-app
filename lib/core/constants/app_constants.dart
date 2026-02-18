class AppConstants {
  // App Info
  static const String appName = 'BudgetBuddy';
  static const String appVersion = '1.0.0';
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String onboardingKey = 'onboarding_completed';
  
  // Hive Boxes
  static const String transactionsBox = 'transactions';
  static const String categoriesBox = 'categories';
  static const String userBox = 'user';
  
  // API Endpoints (REST)
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String transactionsEndpoint = '/transactions';
  static const String categoriesEndpoint = '/categories';
  static const String userEndpoint = '/user';
  static const String analyticsEndpoint = '/analytics';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String transactionsCollection = 'transactions';
  static const String categoriesCollection = 'categories';
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy hh:mm a';
  
  // Pagination
  static const int pageSize = 20;
  
  // Transaction Types
  static const String expenseType = 'expense';
  static const String incomeType = 'income';
  
  // Default Categories
  static const List<String> defaultExpenseCategories = [
    'Food & Dining',
    'Shopping',
    'Transportation',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Education',
    'Travel',
    'Personal Care',
    'Other',
  ];
  
  static const List<String> defaultIncomeCategories = [
    'Salary',
    'Freelance',
    'Investment',
    'Gift',
    'Other',
  ];
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 200;
}
