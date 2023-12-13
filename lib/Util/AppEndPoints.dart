class AppEndPoints {
  static const String baseUrl = "http://10.0.2.2:8000/api/";
  //auth endpoints
  static const String loginEndPoint = "/login";
  static const String logoutEndPoint = "/logout";
  static const String registerEndPoint = "/register";
  static const String profile = "/profile";
  static const String deleteProfile = "/delete-profile";

  //mapping endpoints
  static const String mappings = "/mappings";

  //route plan end points
  static const String routePlan = "/route-plans";

  //sales end points
  static const String sales = "/sales";

  //products end points
  static const String products = "/products";

  //update products end points
  static const String updateProducts = "/products/{product}";

  //delete products end points
  static const String deleteProducts = "/products/{product}";

  //update quantity products end points
  static const String updateQuantityProducts = "/update-quantity/{product}";

  //coffee products end points
  static const String coffeeProducts = "/get-coffee-products";

  //coffee machines end points
  static const String coffeeMachines = "/get-coffee-machines";

  //visits end points
  static const String visits = "/visits";

  //deliveries end points
  static const String deliveries = "/deliveries";

  //appointments end points
  static const String appointments = "/appointments";

  //maintenance end points
  static const String maintenances = "/maintenances";

  //demos end points
  static const String demos = "/demos";

  //contacts end points
  static const String contacts = "/contacts";
}
