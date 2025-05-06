import 'package:get/get.dart';

import '../modules/about_author/bindings/about_author_binding.dart';
import '../modules/about_author/views/about_author_view.dart';
import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/bottom_nav/bindings/bottom_nav_binding.dart';
import '../modules/bottom_nav/views/bottom_nav_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_orders/bindings/my_orders_binding.dart';
import '../modules/my_orders/views/my_orders_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/password_updated/bindings/password_updated_binding.dart';
import '../modules/password_updated/views/password_updated_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/recovery_screen/bindings/recovery_screen_binding.dart';
import '../modules/recovery_screen/views/recovery_screen_view.dart';
import '../modules/search_product/bindings/search_product_binding.dart';
import '../modules/search_product/views/search_product_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/single_product/bindings/single_product_binding.dart';
import '../modules/single_product/views/single_product_view.dart';
import '../modules/success_purchased/bindings/success_purchased_binding.dart';
import '../modules/success_purchased/views/success_purchased_view.dart';
import '../modules/terms_of_service/bindings/terms_of_service_binding.dart';
import '../modules/terms_of_service/views/terms_of_service_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SINGLE_PRODUCT,
      page: () => const SingleProductView(),
      binding: SingleProductBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_SCREEN,
      page: () => RecoveryScreenView(),
      binding: RecoveryScreenBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_AUTHOR,
      page: () => AboutAuthorView(),
      binding: AboutAuthorBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAV,
      page: () => BottomNavView(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () =>  AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_OF_SERVICE,
      page: () => const TermsOfServiceView(),
      binding: TermsOfServiceBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_PRODUCT,
      page: () => const SearchProductView(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_UPDATED,
      page: () => const PasswordUpdatedView(),
      binding: PasswordUpdatedBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS_PURCHASED,
      page: () => const SuccessPurchasedView(),
      binding: SuccessPurchasedBinding(),
    ),
    GetPage(
      name: _Paths.MY_ORDERS,
      page: () => const MyOrdersView(),
      binding: MyOrdersBinding(),
    ),
  ];
}
