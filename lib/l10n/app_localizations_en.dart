// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get storeManagerLogin => 'Store Manager Login';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get or => 'OR';

  @override
  String get createNewAccount => 'Create New Account';

  @override
  String get pleaseEnterMobile => 'Please enter your mobile number';

  @override
  String get invalidMobile => 'Mobile number must contain only digits';

  @override
  String get pleaseEnterPassword => 'Please enter your password';

  @override
  String get invalidCredentials => 'Invalid mobile number or password';

  @override
  String welcome(Object name) {
    return 'Welcome, $name';
  }

  @override
  String get storeManager => 'Store Manager';

  @override
  String get noActiveDeliveries => 'No Active Deliveries';

  @override
  String get createNewDeliveryRequestToGetStarted =>
      'Create a new delivery request to get started';

  @override
  String get activeRequest => 'Active Request';

  @override
  String stops(Object count) {
    return '$count stop(s)';
  }

  @override
  String offersAvailable(Object count) {
    return '$count offer(s) available';
  }

  @override
  String get createNewDeliveryRequest => 'Create New Delivery Request';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get history => 'History';

  @override
  String get reports => 'Reports';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get toggleTheme => 'Toggle between light and dark theme';

  @override
  String get debugSettings => 'Debug Settings';

  @override
  String get fastTimers => 'Fast Timers';

  @override
  String get fastTimersDescription => '10min → 1min, 30s → 5s';

  @override
  String get forceNoDrivers => 'Force No Drivers';

  @override
  String get forceNoDriversDescription => 'Simulate no available drivers';

  @override
  String get seedFakeData => 'Seed Fake Data';

  @override
  String get addedFakeRequests => 'Added 5 fake requests';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmClearAllData => 'This will clear all requests and settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get close => 'Close';

  @override
  String get logout => 'Logout';

  @override
  String get confirmLogout => 'Are you sure you want to logout?';

  @override
  String get language => 'Language';

  @override
  String get toggleLanguage => 'Switch between English and Arabic';

  @override
  String get appSlogan => 'Streamline your delivery, share the load';

  @override
  String get storeRegistration => 'Store Registration';

  @override
  String get step1Of3 => 'Step 1 of 3';

  @override
  String get storeInformation => 'Store Information';

  @override
  String get setupYourStore => 'Let\'s start by setting up your store';

  @override
  String get storeType => 'Store Type *';

  @override
  String get selectStoreType => 'Please select a store type';

  @override
  String get storeName => 'Store Name *';

  @override
  String get enterStoreName => 'Please enter store name';

  @override
  String get hotline => 'Hotline *';

  @override
  String get enterHotline => 'Please enter hotline number';

  @override
  String get invalidHotline => 'Hotline must contain only digits';

  @override
  String get next => 'Next';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get loginAction => 'Login';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get pharmacy => 'Pharmacy';

  @override
  String get supermarket => 'Supermarket';

  @override
  String get other => 'Other';

  @override
  String get branchRegistration => 'Branch Registration';

  @override
  String get step2Of3 => 'Step 2 of 3';

  @override
  String get firstBranch => 'First Branch';

  @override
  String get addBranchDetails =>
      'Add your first branch location and contact details';

  @override
  String get branchName => 'Branch Name *';

  @override
  String get enterBranchName => 'Please enter branch name';

  @override
  String get country => 'Country *';

  @override
  String get selectCountry => 'Please select a country';

  @override
  String get city => 'City *';

  @override
  String get selectCity => 'Please select a city';

  @override
  String get region => 'Region *';

  @override
  String get selectRegion => 'Please select a region';

  @override
  String get address => 'Address *';

  @override
  String get enterAddress => 'Please enter address';

  @override
  String location(Object coordinates) {
    return 'Location: $coordinates';
  }

  @override
  String get landline => 'Landline *';

  @override
  String get enterLandline => 'Please enter landline';

  @override
  String get mobile => 'Mobile *';

  @override
  String get enterMobile => 'Please enter mobile';

  @override
  String get additionalMobile => 'Additional Mobile (Optional)';

  @override
  String get mustContainDigits => 'Must contain only digits';

  @override
  String get gettingLocation => 'Getting Location...';

  @override
  String get getCurrentLocation => 'Get Current Location';

  @override
  String get failedToGetLocation =>
      'Failed to get location. Using mock coordinates.';

  @override
  String get pleaseGetLocation => 'Please get current location first';

  @override
  String get back => 'Back';

  @override
  String get managerAccount => 'Manager Account';

  @override
  String get step3Of3 => 'Step 3 of 3';

  @override
  String get createManagerAccount =>
      'Create your manager account to access the system';

  @override
  String get managerName => 'Manager Name *';

  @override
  String get enterManagerName => 'Please enter manager name';

  @override
  String get managerMobile => 'Mobile Number *';

  @override
  String get enterManagerMobile => 'Please enter mobile number';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get confirmPassword => 'Confirm Password *';

  @override
  String get confirmPasswordHint => 'Please confirm password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get complete => 'Complete';

  @override
  String get registrationSuccess => 'Registration completed successfully!';

  @override
  String get reportsAndAnalytics => 'Reports & Analytics';

  @override
  String get trackPerformance => 'Track your delivery performance';

  @override
  String get daily => 'Daily';

  @override
  String get weekly => 'Weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get overview => 'Overview';

  @override
  String get totalRequests => 'Total Requests';

  @override
  String get delivered => 'Delivered';

  @override
  String get expired => 'Expired';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get deliveredOrders => 'Delivered Orders';

  @override
  String get totalOrders => 'Total Orders';

  @override
  String get ordersAmount => 'Orders Amount';

  @override
  String get excludingDeliveryFees => 'Excluding delivery fees';

  @override
  String get deliveryFees => 'Delivery Fees';

  @override
  String get totalFeesCollected => 'Total fees collected';

  @override
  String get expiredOrders => 'Expired Orders';

  @override
  String get totalExpired => 'Total Expired';

  @override
  String percentageOfTotal(Object percentage) {
    return '$percentage% of total';
  }

  @override
  String get noExpiredRequests => 'No expired requests';

  @override
  String get cancelledOrders => 'Cancelled Orders';

  @override
  String get totalCancelled => 'Total Cancelled';

  @override
  String get greatJob => 'Great job!';

  @override
  String get financialSummary => 'Financial Summary';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String basedOn(Object count, Object plural) {
    return 'Based on $count delivered order$plural';
  }

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get newDeliveryRequest => 'New Delivery Request';

  @override
  String get addAnotherStop => 'Add Another Stop';

  @override
  String get summary => 'Summary';

  @override
  String get subtotalOrders => 'Subtotal (Orders)';

  @override
  String get grandTotal => 'Grand Total';

  @override
  String get reviewRequest => 'Review Request';

  @override
  String stop(Object number) {
    return 'Stop $number';
  }

  @override
  String get orderAmount => 'Order Amount *';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get removeStop => 'Remove Stop';

  @override
  String get requestNotFound => 'Request not found';

  @override
  String request(Object id) {
    return 'Request #$id';
  }

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(Object minutes) {
    return '${minutes}m ago';
  }

  @override
  String hoursAgo(Object hours) {
    return '${hours}h ago';
  }

  @override
  String daysAgo(Object days) {
    return '${days}d ago';
  }

  @override
  String get currentStatus => 'Current Status';

  @override
  String get driver => 'Driver';

  @override
  String get requestExpiresIn => 'Request Expires In';

  @override
  String get availableOffers => 'Available Offers';

  @override
  String get searchingForDrivers => 'Searching for Drivers';

  @override
  String get notifyingDrivers =>
      'We\'re notifying nearby drivers about your request';

  @override
  String get requestExpired => 'Request Expired';

  @override
  String get noDriversAccepted => 'No drivers accepted within the time limit';

  @override
  String get retryRequest => 'Retry Request';

  @override
  String get deliveryStops => 'Delivery Stops';

  @override
  String get fee => 'fee';

  @override
  String get timeline => 'Timeline';

  @override
  String get cancelRequest => 'Cancel Request';

  @override
  String offerAccepted(Object driverName) {
    return 'Offer from $driverName accepted!';
  }

  @override
  String get confirmCancel => 'Cancel Request?';

  @override
  String get confirmCancelMessage =>
      'Are you sure you want to cancel this delivery request?';

  @override
  String get no => 'No';

  @override
  String get yesCancel => 'Yes, Cancel';

  @override
  String get confirmRequest => 'Confirm Request';

  @override
  String get reviewBeforeSending => 'Review before sending';

  @override
  String get infoMessage =>
      'Your request will be sent to nearby drivers. You\'ll receive offers within minutes.';

  @override
  String order(Object amount) {
    return 'Order: EGP $amount';
  }

  @override
  String feeWithAmount(Object amount) {
    return 'Fee: EGP $amount';
  }

  @override
  String get paymentSummary => 'Payment Summary';

  @override
  String get ordersSubtotal => 'Orders Subtotal';

  @override
  String get edit => 'Edit';

  @override
  String get sendRequest => 'Send Request';

  @override
  String get requestSent => 'Request sent! Searching for drivers...';

  @override
  String get status => 'Status';

  @override
  String get requestId => 'Request ID';

  @override
  String get created => 'Created';

  @override
  String get at => 'at';

  @override
  String get requestAgain => 'Request Again?';

  @override
  String get useSameStops => 'Use the same delivery stops for a new request';

  @override
  String get createNewRequest => 'Create New Request';

  @override
  String get requestHistory => 'Request History';

  @override
  String get allPastDeliveries => 'All your past deliveries';

  @override
  String get all => 'All';

  @override
  String get noRequestsYet => 'No requests yet';

  @override
  String noRequestsOfType(Object type) {
    return 'No $type requests';
  }

  @override
  String get createFirstRequest =>
      'Create your first delivery request to get started';

  @override
  String get tryDifferentFilter => 'Try selecting a different filter';

  @override
  String todayAt(Object time) {
    return 'Today at $time';
  }

  @override
  String yesterdayAt(Object time) {
    return 'Yesterday at $time';
  }

  @override
  String daysAgoFormatted(Object days) {
    return '$days days ago';
  }

  @override
  String get notesOptional => 'Notes (optional)';

  @override
  String get searching => 'Searching';

  @override
  String get offerReceived => 'Offer Received';

  @override
  String get accepted => 'Accepted';

  @override
  String get outForDelivery => 'Out for Delivery';

  @override
  String get unknown => 'Unknown';

  @override
  String get counter => 'COUNTER';

  @override
  String get proposedFee => 'Proposed Fee';

  @override
  String original(Object amount) {
    return 'Original: EGP $amount';
  }

  @override
  String get eta => 'ETA';

  @override
  String minutes(Object minutes) {
    return '$minutes min';
  }

  @override
  String get accept => 'Accept';

  @override
  String get onboardingTitle1 => 'Multi-Stop Delivery';

  @override
  String get onboardingDesc1 =>
      'Create delivery requests with multiple customer addresses. Use autocomplete to find addresses quickly.';

  @override
  String get onboardingTitle2 => 'Receive Offers';

  @override
  String get onboardingDesc2 =>
      'Nearby drivers will send offers. Each offer is valid for 30 seconds. Accept the best one!';

  @override
  String get onboardingTitle3 => 'Track Delivery';

  @override
  String get onboardingDesc3 =>
      'Monitor your delivery in real-time from pickup to completion. All requests are saved in history.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get toStore => 'To Store';

  @override
  String get pickedUp => 'Picked Up';

  @override
  String get delivering => 'Delivering';
}
