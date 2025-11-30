import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @storeManagerLogin.
  ///
  /// In en, this message translates to:
  /// **'Store Manager Login'**
  String get storeManagerLogin;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @signInToContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get signInToContinue;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createNewAccount;

  /// No description provided for @pleaseEnterMobile.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number'**
  String get pleaseEnterMobile;

  /// No description provided for @invalidMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile number must contain only digits'**
  String get invalidMobile;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number or password'**
  String get invalidCredentials;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String welcome(Object name);

  /// No description provided for @storeManager.
  ///
  /// In en, this message translates to:
  /// **'Store Manager'**
  String get storeManager;

  /// No description provided for @noActiveDeliveries.
  ///
  /// In en, this message translates to:
  /// **'No Active Deliveries'**
  String get noActiveDeliveries;

  /// No description provided for @createNewDeliveryRequestToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Create a new delivery request to get started'**
  String get createNewDeliveryRequestToGetStarted;

  /// No description provided for @activeRequest.
  ///
  /// In en, this message translates to:
  /// **'Active Request'**
  String get activeRequest;

  /// No description provided for @stops.
  ///
  /// In en, this message translates to:
  /// **'{count} stop(s)'**
  String stops(Object count);

  /// No description provided for @offersAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} offer(s) available'**
  String offersAvailable(Object count);

  /// No description provided for @createNewDeliveryRequest.
  ///
  /// In en, this message translates to:
  /// **'Create New Delivery Request'**
  String get createNewDeliveryRequest;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @toggleTheme.
  ///
  /// In en, this message translates to:
  /// **'Toggle between light and dark theme'**
  String get toggleTheme;

  /// No description provided for @debugSettings.
  ///
  /// In en, this message translates to:
  /// **'Debug Settings'**
  String get debugSettings;

  /// No description provided for @fastTimers.
  ///
  /// In en, this message translates to:
  /// **'Fast Timers'**
  String get fastTimers;

  /// No description provided for @fastTimersDescription.
  ///
  /// In en, this message translates to:
  /// **'10min → 1min, 30s → 5s'**
  String get fastTimersDescription;

  /// No description provided for @forceNoDrivers.
  ///
  /// In en, this message translates to:
  /// **'Force No Drivers'**
  String get forceNoDrivers;

  /// No description provided for @forceNoDriversDescription.
  ///
  /// In en, this message translates to:
  /// **'Simulate no available drivers'**
  String get forceNoDriversDescription;

  /// No description provided for @seedFakeData.
  ///
  /// In en, this message translates to:
  /// **'Seed Fake Data'**
  String get seedFakeData;

  /// No description provided for @addedFakeRequests.
  ///
  /// In en, this message translates to:
  /// **'Added 5 fake requests'**
  String get addedFakeRequests;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmClearAllData.
  ///
  /// In en, this message translates to:
  /// **'This will clear all requests and settings'**
  String get confirmClearAllData;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @toggleLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch between English and Arabic'**
  String get toggleLanguage;

  /// No description provided for @appSlogan.
  ///
  /// In en, this message translates to:
  /// **'Streamline your delivery, share the load'**
  String get appSlogan;

  /// No description provided for @storeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Store Registration'**
  String get storeRegistration;

  /// No description provided for @step1Of3.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 3'**
  String get step1Of3;

  /// No description provided for @storeInformation.
  ///
  /// In en, this message translates to:
  /// **'Store Information'**
  String get storeInformation;

  /// No description provided for @setupYourStore.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start by setting up your store'**
  String get setupYourStore;

  /// No description provided for @storeType.
  ///
  /// In en, this message translates to:
  /// **'Store Type *'**
  String get storeType;

  /// No description provided for @selectStoreType.
  ///
  /// In en, this message translates to:
  /// **'Please select a store type'**
  String get selectStoreType;

  /// No description provided for @storeName.
  ///
  /// In en, this message translates to:
  /// **'Store Name *'**
  String get storeName;

  /// No description provided for @enterStoreName.
  ///
  /// In en, this message translates to:
  /// **'Please enter store name'**
  String get enterStoreName;

  /// No description provided for @hotline.
  ///
  /// In en, this message translates to:
  /// **'Hotline *'**
  String get hotline;

  /// No description provided for @enterHotline.
  ///
  /// In en, this message translates to:
  /// **'Please enter hotline number'**
  String get enterHotline;

  /// No description provided for @invalidHotline.
  ///
  /// In en, this message translates to:
  /// **'Hotline must contain only digits'**
  String get invalidHotline;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @loginAction.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginAction;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @pharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get pharmacy;

  /// No description provided for @supermarket.
  ///
  /// In en, this message translates to:
  /// **'Supermarket'**
  String get supermarket;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @branchRegistration.
  ///
  /// In en, this message translates to:
  /// **'Branch Registration'**
  String get branchRegistration;

  /// No description provided for @step2Of3.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 3'**
  String get step2Of3;

  /// No description provided for @firstBranch.
  ///
  /// In en, this message translates to:
  /// **'First Branch'**
  String get firstBranch;

  /// No description provided for @addBranchDetails.
  ///
  /// In en, this message translates to:
  /// **'Add your first branch location and contact details'**
  String get addBranchDetails;

  /// No description provided for @branchName.
  ///
  /// In en, this message translates to:
  /// **'Branch Name *'**
  String get branchName;

  /// No description provided for @enterBranchName.
  ///
  /// In en, this message translates to:
  /// **'Please enter branch name'**
  String get enterBranchName;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country *'**
  String get country;

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Please select a country'**
  String get selectCountry;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City *'**
  String get city;

  /// No description provided for @selectCity.
  ///
  /// In en, this message translates to:
  /// **'Please select a city'**
  String get selectCity;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region *'**
  String get region;

  /// No description provided for @selectRegion.
  ///
  /// In en, this message translates to:
  /// **'Please select a region'**
  String get selectRegion;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address *'**
  String get address;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter address'**
  String get enterAddress;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location: {coordinates}'**
  String location(Object coordinates);

  /// No description provided for @landline.
  ///
  /// In en, this message translates to:
  /// **'Landline *'**
  String get landline;

  /// No description provided for @enterLandline.
  ///
  /// In en, this message translates to:
  /// **'Please enter landline'**
  String get enterLandline;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile *'**
  String get mobile;

  /// No description provided for @enterMobile.
  ///
  /// In en, this message translates to:
  /// **'Please enter mobile'**
  String get enterMobile;

  /// No description provided for @additionalMobile.
  ///
  /// In en, this message translates to:
  /// **'Additional Mobile (Optional)'**
  String get additionalMobile;

  /// No description provided for @mustContainDigits.
  ///
  /// In en, this message translates to:
  /// **'Must contain only digits'**
  String get mustContainDigits;

  /// No description provided for @gettingLocation.
  ///
  /// In en, this message translates to:
  /// **'Getting Location...'**
  String get gettingLocation;

  /// No description provided for @getCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Get Current Location'**
  String get getCurrentLocation;

  /// No description provided for @failedToGetLocation.
  ///
  /// In en, this message translates to:
  /// **'Failed to get location. Using mock coordinates.'**
  String get failedToGetLocation;

  /// No description provided for @pleaseGetLocation.
  ///
  /// In en, this message translates to:
  /// **'Please get current location first'**
  String get pleaseGetLocation;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @managerAccount.
  ///
  /// In en, this message translates to:
  /// **'Manager Account'**
  String get managerAccount;

  /// No description provided for @step3Of3.
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 3'**
  String get step3Of3;

  /// No description provided for @createManagerAccount.
  ///
  /// In en, this message translates to:
  /// **'Create your manager account to access the system'**
  String get createManagerAccount;

  /// No description provided for @managerName.
  ///
  /// In en, this message translates to:
  /// **'Manager Name *'**
  String get managerName;

  /// No description provided for @enterManagerName.
  ///
  /// In en, this message translates to:
  /// **'Please enter manager name'**
  String get enterManagerName;

  /// No description provided for @managerMobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number *'**
  String get managerMobile;

  /// No description provided for @enterManagerMobile.
  ///
  /// In en, this message translates to:
  /// **'Please enter mobile number'**
  String get enterManagerMobile;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password *'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get confirmPasswordHint;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully!'**
  String get registrationSuccess;

  /// No description provided for @reportsAndAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Reports & Analytics'**
  String get reportsAndAnalytics;

  /// No description provided for @trackPerformance.
  ///
  /// In en, this message translates to:
  /// **'Track your delivery performance'**
  String get trackPerformance;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @totalRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Requests'**
  String get totalRequests;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @expired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @deliveredOrders.
  ///
  /// In en, this message translates to:
  /// **'Delivered Orders'**
  String get deliveredOrders;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @ordersAmount.
  ///
  /// In en, this message translates to:
  /// **'Orders Amount'**
  String get ordersAmount;

  /// No description provided for @excludingDeliveryFees.
  ///
  /// In en, this message translates to:
  /// **'Excluding delivery fees'**
  String get excludingDeliveryFees;

  /// No description provided for @deliveryFees.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fees'**
  String get deliveryFees;

  /// No description provided for @totalFeesCollected.
  ///
  /// In en, this message translates to:
  /// **'Total fees collected'**
  String get totalFeesCollected;

  /// No description provided for @expiredOrders.
  ///
  /// In en, this message translates to:
  /// **'Expired Orders'**
  String get expiredOrders;

  /// No description provided for @totalExpired.
  ///
  /// In en, this message translates to:
  /// **'Total Expired'**
  String get totalExpired;

  /// No description provided for @percentageOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% of total'**
  String percentageOfTotal(Object percentage);

  /// No description provided for @noExpiredRequests.
  ///
  /// In en, this message translates to:
  /// **'No expired requests'**
  String get noExpiredRequests;

  /// No description provided for @cancelledOrders.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Orders'**
  String get cancelledOrders;

  /// No description provided for @totalCancelled.
  ///
  /// In en, this message translates to:
  /// **'Total Cancelled'**
  String get totalCancelled;

  /// No description provided for @greatJob.
  ///
  /// In en, this message translates to:
  /// **'Great job!'**
  String get greatJob;

  /// No description provided for @financialSummary.
  ///
  /// In en, this message translates to:
  /// **'Financial Summary'**
  String get financialSummary;

  /// No description provided for @totalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// No description provided for @basedOn.
  ///
  /// In en, this message translates to:
  /// **'Based on {count} delivered order{plural}'**
  String basedOn(Object count, Object plural);

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @newDeliveryRequest.
  ///
  /// In en, this message translates to:
  /// **'New Delivery Request'**
  String get newDeliveryRequest;

  /// No description provided for @addAnotherStop.
  ///
  /// In en, this message translates to:
  /// **'Add Another Stop'**
  String get addAnotherStop;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @subtotalOrders.
  ///
  /// In en, this message translates to:
  /// **'Subtotal (Orders)'**
  String get subtotalOrders;

  /// No description provided for @grandTotal.
  ///
  /// In en, this message translates to:
  /// **'Grand Total'**
  String get grandTotal;

  /// No description provided for @reviewRequest.
  ///
  /// In en, this message translates to:
  /// **'Review Request'**
  String get reviewRequest;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop {number}'**
  String stop(Object number);

  /// No description provided for @orderAmount.
  ///
  /// In en, this message translates to:
  /// **'Order Amount *'**
  String get orderAmount;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @removeStop.
  ///
  /// In en, this message translates to:
  /// **'Remove Stop'**
  String get removeStop;

  /// No description provided for @requestNotFound.
  ///
  /// In en, this message translates to:
  /// **'Request not found'**
  String get requestNotFound;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request #{id}'**
  String request(Object id);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String minutesAgo(Object minutes);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h ago'**
  String hoursAgo(Object hours);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(Object days);

  /// No description provided for @currentStatus.
  ///
  /// In en, this message translates to:
  /// **'Current Status'**
  String get currentStatus;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @requestExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Request Expires In'**
  String get requestExpiresIn;

  /// No description provided for @availableOffers.
  ///
  /// In en, this message translates to:
  /// **'Available Offers'**
  String get availableOffers;

  /// No description provided for @searchingForDrivers.
  ///
  /// In en, this message translates to:
  /// **'Searching for Drivers'**
  String get searchingForDrivers;

  /// No description provided for @notifyingDrivers.
  ///
  /// In en, this message translates to:
  /// **'We\'re notifying nearby drivers about your request'**
  String get notifyingDrivers;

  /// No description provided for @requestExpired.
  ///
  /// In en, this message translates to:
  /// **'Request Expired'**
  String get requestExpired;

  /// No description provided for @noDriversAccepted.
  ///
  /// In en, this message translates to:
  /// **'No drivers accepted within the time limit'**
  String get noDriversAccepted;

  /// No description provided for @retryRequest.
  ///
  /// In en, this message translates to:
  /// **'Retry Request'**
  String get retryRequest;

  /// No description provided for @deliveryStops.
  ///
  /// In en, this message translates to:
  /// **'Delivery Stops'**
  String get deliveryStops;

  /// No description provided for @fee.
  ///
  /// In en, this message translates to:
  /// **'fee'**
  String get fee;

  /// No description provided for @timeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get timeline;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel Request'**
  String get cancelRequest;

  /// No description provided for @offerAccepted.
  ///
  /// In en, this message translates to:
  /// **'Offer from {driverName} accepted!'**
  String offerAccepted(Object driverName);

  /// No description provided for @confirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel Request?'**
  String get confirmCancel;

  /// No description provided for @confirmCancelMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this delivery request?'**
  String get confirmCancelMessage;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// No description provided for @confirmRequest.
  ///
  /// In en, this message translates to:
  /// **'Confirm Request'**
  String get confirmRequest;

  /// No description provided for @reviewBeforeSending.
  ///
  /// In en, this message translates to:
  /// **'Review before sending'**
  String get reviewBeforeSending;

  /// No description provided for @infoMessage.
  ///
  /// In en, this message translates to:
  /// **'Your request will be sent to nearby drivers. You\'ll receive offers within minutes.'**
  String get infoMessage;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order: EGP {amount}'**
  String order(Object amount);

  /// No description provided for @feeWithAmount.
  ///
  /// In en, this message translates to:
  /// **'Fee: EGP {amount}'**
  String feeWithAmount(Object amount);

  /// No description provided for @paymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Payment Summary'**
  String get paymentSummary;

  /// No description provided for @ordersSubtotal.
  ///
  /// In en, this message translates to:
  /// **'Orders Subtotal'**
  String get ordersSubtotal;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get sendRequest;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent! Searching for drivers...'**
  String get requestSent;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @requestId.
  ///
  /// In en, this message translates to:
  /// **'Request ID'**
  String get requestId;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @at.
  ///
  /// In en, this message translates to:
  /// **'at'**
  String get at;

  /// No description provided for @requestAgain.
  ///
  /// In en, this message translates to:
  /// **'Request Again?'**
  String get requestAgain;

  /// No description provided for @useSameStops.
  ///
  /// In en, this message translates to:
  /// **'Use the same delivery stops for a new request'**
  String get useSameStops;

  /// No description provided for @createNewRequest.
  ///
  /// In en, this message translates to:
  /// **'Create New Request'**
  String get createNewRequest;

  /// No description provided for @requestHistory.
  ///
  /// In en, this message translates to:
  /// **'Request History'**
  String get requestHistory;

  /// No description provided for @allPastDeliveries.
  ///
  /// In en, this message translates to:
  /// **'All your past deliveries'**
  String get allPastDeliveries;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @noRequestsYet.
  ///
  /// In en, this message translates to:
  /// **'No requests yet'**
  String get noRequestsYet;

  /// No description provided for @noRequestsOfType.
  ///
  /// In en, this message translates to:
  /// **'No {type} requests'**
  String noRequestsOfType(Object type);

  /// No description provided for @createFirstRequest.
  ///
  /// In en, this message translates to:
  /// **'Create your first delivery request to get started'**
  String get createFirstRequest;

  /// No description provided for @tryDifferentFilter.
  ///
  /// In en, this message translates to:
  /// **'Try selecting a different filter'**
  String get tryDifferentFilter;

  /// No description provided for @todayAt.
  ///
  /// In en, this message translates to:
  /// **'Today at {time}'**
  String todayAt(Object time);

  /// No description provided for @yesterdayAt.
  ///
  /// In en, this message translates to:
  /// **'Yesterday at {time}'**
  String yesterdayAt(Object time);

  /// No description provided for @daysAgoFormatted.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgoFormatted(Object days);

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get notesOptional;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching'**
  String get searching;

  /// No description provided for @offerReceived.
  ///
  /// In en, this message translates to:
  /// **'Offer Received'**
  String get offerReceived;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @outForDelivery.
  ///
  /// In en, this message translates to:
  /// **'Out for Delivery'**
  String get outForDelivery;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @counter.
  ///
  /// In en, this message translates to:
  /// **'COUNTER'**
  String get counter;

  /// No description provided for @proposedFee.
  ///
  /// In en, this message translates to:
  /// **'Proposed Fee'**
  String get proposedFee;

  /// No description provided for @original.
  ///
  /// In en, this message translates to:
  /// **'Original: EGP {amount}'**
  String original(Object amount);

  /// No description provided for @eta.
  ///
  /// In en, this message translates to:
  /// **'ETA'**
  String get eta;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutes(Object minutes);

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Multi-Stop Delivery'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Create delivery requests with multiple customer addresses. Use autocomplete to find addresses quickly.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Receive Offers'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Nearby drivers will send offers. Each offer is valid for 30 seconds. Accept the best one!'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Track Delivery'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Monitor your delivery in real-time from pickup to completion. All requests are saved in history.'**
  String get onboardingDesc3;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @toStore.
  ///
  /// In en, this message translates to:
  /// **'To Store'**
  String get toStore;

  /// No description provided for @pickedUp.
  ///
  /// In en, this message translates to:
  /// **'Picked Up'**
  String get pickedUp;

  /// No description provided for @delivering.
  ///
  /// In en, this message translates to:
  /// **'Delivering'**
  String get delivering;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
