class ImageLogoUtil {
  static String getLogoForName(String name) {
    if (name.toLowerCase().contains('wellsfargo')) {
      return 'assets/wells_fargo_logo.png';
    }
    if (name.toLowerCase().contains('citi')) {
      return 'assets/citi_logo.png';
    }
    if (name.toLowerCase().contains('ikea')) {
      return 'assets/ikea_logo.png';
    }
    if (name.toLowerCase().contains('food')) {
      return 'assets/category_food_logo.png';
    }
    if (name.toLowerCase().contains('apps')) {
      return 'assets/category_apps_software_logo.png';
    }
    if (name.toLowerCase().contains('health')) {
      return 'assets/category_health_logo.png';
    }
    if (name.toLowerCase().contains('jbl')) {
      return 'assets/jbl_logo.png';
    }
    if (name.toLowerCase().contains('mcdonalds')) {
      return 'assets/mcd_logo.png';
    }
    if (name.toLowerCase().contains('uber')) {
      return 'assets/uber_logo.png';
    }
    if (name.toLowerCase().contains('starbucks')) {
      return 'assets/starbucks_logo.png';
    }
    return 'assets/category_apps_software_logo.png';
  }
}
