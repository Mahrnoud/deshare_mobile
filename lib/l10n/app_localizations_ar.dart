// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hello => 'مرحباً';

  @override
  String get storeManagerLogin => 'دخول مدير المتجر';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get signInToContinue => 'سجل الدخول للمتابعة';

  @override
  String get mobileNumber => 'رقم الجوال';

  @override
  String get password => 'كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get or => 'أو';

  @override
  String get createNewAccount => 'إنشاء حساب جديد';

  @override
  String get pleaseEnterMobile => 'الرجاء إدخال رقم الجوال';

  @override
  String get invalidMobile => 'يجب أن يحتوي رقم الجوال على أرقام فقط';

  @override
  String get pleaseEnterPassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get invalidCredentials => 'رقم الجوال أو كلمة المرور غير صحيحة';

  @override
  String welcome(Object name) {
    return 'أهلاً، $name';
  }

  @override
  String get storeManager => 'مدير المتجر';

  @override
  String get noActiveDeliveries => 'لا توجد توصيلات نشطة';

  @override
  String get createNewDeliveryRequestToGetStarted =>
      'قم بإنشاء طلب توصيل جديد للبدء';

  @override
  String get activeRequest => 'طلب نشط';

  @override
  String stops(Object count) {
    return '$count محطة(ات)';
  }

  @override
  String offersAvailable(Object count) {
    return '$count عرض متاح';
  }

  @override
  String get createNewDeliveryRequest => 'إنشاء طلب توصيل جديد';

  @override
  String get quickActions => 'إجراءات سريعة';

  @override
  String get history => 'السجل';

  @override
  String get reports => 'التقارير';

  @override
  String get settings => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get toggleTheme => 'التبديل بين الوضع الفاتح والداكن';

  @override
  String get debugSettings => 'إعدادات التصحيح';

  @override
  String get fastTimers => 'مؤقتات سريعة';

  @override
  String get fastTimersDescription => '10د ← 1د، 30ث ← 5ث';

  @override
  String get forceNoDrivers => 'فرض عدم وجود سائقين';

  @override
  String get forceNoDriversDescription => 'محاكاة عدم وجود سائقين متاحين';

  @override
  String get seedFakeData => 'إدخال بيانات وهمية';

  @override
  String get addedFakeRequests => 'تمت إضافة 5 طلبات وهمية';

  @override
  String get clearAllData => 'مسح كل البيانات';

  @override
  String get confirm => 'تأكيد';

  @override
  String get confirmClearAllData => 'سيؤدي هذا إلى مسح جميع الطلبات والإعدادات';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clear => 'مسح';

  @override
  String get close => 'إغلاق';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get confirmLogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get language => 'اللغة';

  @override
  String get toggleLanguage => 'التبديل بين اللغتين الإنجليزية والعربية';

  @override
  String get appSlogan => 'قم بتبسيط عملية التسليم الخاصة بك، وشارك الحمل';

  @override
  String get storeRegistration => 'تسجيل متجر';

  @override
  String get step1Of3 => 'الخطوة 1 من 3';

  @override
  String get storeInformation => 'معلومات المتجر';

  @override
  String get setupYourStore => 'لنبدأ بإعداد متجرك';

  @override
  String get storeType => 'نوع المتجر *';

  @override
  String get selectStoreType => 'الرجاء تحديد نوع المتجر';

  @override
  String get storeName => 'اسم المتجر *';

  @override
  String get enterStoreName => 'الرجاء إدخال اسم المتجر';

  @override
  String get hotline => 'الخط الساخن *';

  @override
  String get enterHotline => 'الرجاء إدخال رقم الخط الساخن';

  @override
  String get invalidHotline => 'يجب أن يحتوي الخط الساخن على أرقام فقط';

  @override
  String get next => 'التالي';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ ';

  @override
  String get loginAction => 'تسجيل الدخول';

  @override
  String get restaurant => 'مطعم';

  @override
  String get pharmacy => 'صيدلية';

  @override
  String get supermarket => 'سوبر ماركت';

  @override
  String get other => 'آخر';

  @override
  String get branchRegistration => 'تسجيل فرع';

  @override
  String get step2Of3 => 'الخطوة 2 من 3';

  @override
  String get firstBranch => 'الفرع الأول';

  @override
  String get addBranchDetails => 'أضف موقع فرعك الأول وتفاصيل الاتصال';

  @override
  String get branchName => 'اسم الفرع *';

  @override
  String get enterBranchName => 'الرجاء إدخال اسم الفرع';

  @override
  String get country => 'الدولة *';

  @override
  String get selectCountry => 'الرجاء تحديد الدولة';

  @override
  String get city => 'المدينة *';

  @override
  String get selectCity => 'الرجاء تحديد المدينة';

  @override
  String get region => 'المنطقة *';

  @override
  String get selectRegion => 'الرجاء تحديد المنطقة';

  @override
  String get address => 'العنوان *';

  @override
  String get enterAddress => 'الرجاء إدخال العنوان';

  @override
  String location(Object coordinates) {
    return 'الموقع: $coordinates';
  }

  @override
  String get landline => 'الهاتف الأرضي *';

  @override
  String get enterLandline => 'الرجاء إدخال الهاتف الأرضي';

  @override
  String get mobile => 'الجوال *';

  @override
  String get enterMobile => 'الرجاء إدخال الجوال';

  @override
  String get additionalMobile => 'جوال إضافي (اختياري)';

  @override
  String get mustContainDigits => 'يجب أن يحتوي على أرقام فقط';

  @override
  String get gettingLocation => 'جاري تحديد الموقع...';

  @override
  String get getCurrentLocation => 'تحديد الموقع الحالي';

  @override
  String get failedToGetLocation =>
      'فشل تحديد الموقع. سيتم استخدام إحداثيات وهمية.';

  @override
  String get pleaseGetLocation => 'الرجاء تحديد الموقع الحالي أولاً';

  @override
  String get back => 'رجوع';

  @override
  String get managerAccount => 'حساب المدير';

  @override
  String get step3Of3 => 'الخطوة 3 من 3';

  @override
  String get createManagerAccount =>
      'أنشئ حساب المدير الخاص بك للوصول إلى النظام';

  @override
  String get managerName => 'اسم المدير *';

  @override
  String get enterManagerName => 'الرجاء إدخال اسم المدير';

  @override
  String get managerMobile => 'رقم الجوال *';

  @override
  String get enterManagerMobile => 'الرجاء إدخال رقم الجوال';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور *';

  @override
  String get confirmPasswordHint => 'الرجاء تأكيد كلمة المرور';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get complete => 'إكمال';

  @override
  String get registrationSuccess => 'اكتمل التسجيل بنجاح!';

  @override
  String get reportsAndAnalytics => 'التقارير والتحليلات';

  @override
  String get trackPerformance => 'تتبع أداء التوصيل الخاص بك';

  @override
  String get daily => 'يومي';

  @override
  String get weekly => 'أسبوعي';

  @override
  String get monthly => 'شهري';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get totalRequests => 'إجمالي الطلبات';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String get expired => 'منتهي الصلاحية';

  @override
  String get cancelled => 'ملغاة';

  @override
  String get deliveredOrders => 'الطلبات التي تم توصيلها';

  @override
  String get totalOrders => 'إجمالي الطلبات';

  @override
  String get ordersAmount => 'مبلغ الطلبات';

  @override
  String get excludingDeliveryFees => 'باستثناء رسوم التوصيل';

  @override
  String get deliveryFees => 'رسوم التوصيل';

  @override
  String get totalFeesCollected => 'إجمالي الرسوم المحصلة';

  @override
  String get expiredOrders => 'الطلبات منتهية الصلاحية';

  @override
  String get totalExpired => 'إجمالي الطلبات منتهية الصلاحية';

  @override
  String percentageOfTotal(Object percentage) {
    return '$percentage٪ من المجموع';
  }

  @override
  String get noExpiredRequests => 'لا توجد طلبات منتهية الصلاحية';

  @override
  String get cancelledOrders => 'الطلبات الملغاة';

  @override
  String get totalCancelled => 'إجمالي الطلبات الملغاة';

  @override
  String get greatJob => 'عمل رائع!';

  @override
  String get financialSummary => 'ملخص مالي';

  @override
  String get totalRevenue => 'إجمالي الإيرادات';

  @override
  String basedOn(Object count, Object plural) {
    return 'بناءً على $count طلب تم توصيله';
  }

  @override
  String get january => 'يناير';

  @override
  String get february => 'فبراير';

  @override
  String get march => 'مارس';

  @override
  String get april => 'أبريل';

  @override
  String get may => 'مايو';

  @override
  String get june => 'يونيو';

  @override
  String get july => 'يوليو';

  @override
  String get august => 'أغسطس';

  @override
  String get september => 'سبتمبر';

  @override
  String get october => 'أكتوبر';

  @override
  String get november => 'نوفمبر';

  @override
  String get december => 'ديسمبر';

  @override
  String get newDeliveryRequest => 'طلب توصيل جديد';

  @override
  String get addAnotherStop => 'أضف محطة أخرى';

  @override
  String get summary => 'ملخص';

  @override
  String get subtotalOrders => 'المجموع الفرعي (الطلبات)';

  @override
  String get grandTotal => 'المجموع الإجمالي';

  @override
  String get reviewRequest => 'مراجعة الطلب';

  @override
  String stop(Object number) {
    return 'محطة $number';
  }

  @override
  String get orderAmount => 'مبلغ الطلب *';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get removeStop => 'إزالة المحطة';

  @override
  String get requestNotFound => 'الطلب غير موجود';

  @override
  String request(Object id) {
    return 'طلب #$id';
  }

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(Object minutes) {
    return 'قبل $minutes دقيقة';
  }

  @override
  String hoursAgo(Object hours) {
    return 'قبل $hours ساعة';
  }

  @override
  String daysAgo(Object days) {
    return 'قبل $days يوم';
  }

  @override
  String get currentStatus => 'الحالة الحالية';

  @override
  String get driver => 'السائق';

  @override
  String get requestExpiresIn => 'ينتهي الطلب في';

  @override
  String get availableOffers => 'العروض المتاحة';

  @override
  String get searchingForDrivers => 'جاري البحث عن سائقين';

  @override
  String get notifyingDrivers => 'نقوم بإعلام السائقين القريبين بطلبك';

  @override
  String get requestExpired => 'انتهت صلاحية الطلب';

  @override
  String get noDriversAccepted => 'لم يقبل أي سائق في غضون المهلة الزمنية';

  @override
  String get retryRequest => 'إعادة محاولة الطلب';

  @override
  String get deliveryStops => 'محطات التوصيل';

  @override
  String get fee => 'رسوم';

  @override
  String get timeline => 'الجدول الزمني';

  @override
  String get cancelRequest => 'إلغاء الطلب';

  @override
  String offerAccepted(Object driverName) {
    return 'تم قبول العرض من $driverName!';
  }

  @override
  String get confirmCancel => 'إلغاء الطلب؟';

  @override
  String get confirmCancelMessage =>
      'هل أنت متأكد أنك تريد إلغاء طلب التوصيل هذا؟';

  @override
  String get no => 'لا';

  @override
  String get yesCancel => 'نعم، إلغاء';

  @override
  String get confirmRequest => 'تأكيد الطلب';

  @override
  String get reviewBeforeSending => 'مراجعة قبل الإرسال';

  @override
  String get infoMessage =>
      'سيتم إرسال طلبك إلى السائقين القريبين. ستتلقى عروضًا في غضون دقائق.';

  @override
  String order(Object amount) {
    return 'الطلب: EGP $amount';
  }

  @override
  String feeWithAmount(Object amount) {
    return 'الرسوم: EGP $amount';
  }

  @override
  String get paymentSummary => 'ملخص الدفع';

  @override
  String get ordersSubtotal => 'المجموع الفرعي للطلبات';

  @override
  String get edit => 'تعديل';

  @override
  String get sendRequest => 'إرسال الطلب';

  @override
  String get requestSent => 'تم إرسال الطلب! جاري البحث عن سائقين...';

  @override
  String get status => 'الحالة';

  @override
  String get requestId => 'معرف الطلب';

  @override
  String get created => 'تم الإنشاء';

  @override
  String get at => 'في';

  @override
  String get requestAgain => 'إعادة الطلب؟';

  @override
  String get useSameStops => 'استخدام نفس محطات التوصيل لطلب جديد';

  @override
  String get createNewRequest => 'إنشاء طلب جديد';

  @override
  String get requestHistory => 'سجل الطلبات';

  @override
  String get allPastDeliveries => 'جميع توصيلاتك السابقة';

  @override
  String get all => 'الكل';

  @override
  String get noRequestsYet => 'لا توجد طلبات حتى الآن';

  @override
  String noRequestsOfType(Object type) {
    return 'لا توجد طلبات من نوع $type';
  }

  @override
  String get createFirstRequest => 'قم بإنشاء طلب التوصيل الأول للبدء';

  @override
  String get tryDifferentFilter => 'جرب تحديد فلتر مختلف';

  @override
  String todayAt(Object time) {
    return 'اليوم في $time';
  }

  @override
  String yesterdayAt(Object time) {
    return 'أمس في $time';
  }

  @override
  String daysAgoFormatted(Object days) {
    return 'قبل $days أيام';
  }

  @override
  String get notesOptional => 'ملاحظات (اختياري)';

  @override
  String get searching => 'جاري البحث';

  @override
  String get offerReceived => 'تم استلام العرض';

  @override
  String get accepted => 'مقبول';

  @override
  String get outForDelivery => 'خارج للتوصيل';

  @override
  String get unknown => 'غير معروف';

  @override
  String get counter => 'عرض مضاد';

  @override
  String get proposedFee => 'الرسوم المقترحة';

  @override
  String original(Object amount) {
    return 'الأصلي: EGP $amount';
  }

  @override
  String get eta => 'الوقت المتوقع للوصول';

  @override
  String minutes(Object minutes) {
    return '$minutes دقيقة';
  }

  @override
  String get accept => 'قبول';

  @override
  String get onboardingTitle1 => 'توصيل متعدد المحطات';

  @override
  String get onboardingDesc1 =>
      'أنشئ طلبات توصيل بعناوين عملاء متعددة. استخدم الإكمال التلقائي للعثور على العناوين بسرعة.';

  @override
  String get onboardingTitle2 => 'استقبال العروض';

  @override
  String get onboardingDesc2 =>
      'سيرسل السائقون القريبون عروضًا. كل عرض صالح لمدة 30 ثانية. اقبل الأفضل!';

  @override
  String get onboardingTitle3 => 'تتبع التوصيل';

  @override
  String get onboardingDesc3 =>
      'راقب توصيلك في الوقت الفعلي من الاستلام إلى الإكمال. يتم حفظ جميع الطلبات في السجل.';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get toStore => 'إلى المتجر';

  @override
  String get pickedUp => 'تم الاستلام';

  @override
  String get delivering => 'جاري التوصيل';
}
