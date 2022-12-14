import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_new/screens/auth/register/list_nationalites/list_nationalites_json.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/listOfCountry/list_of_country_json.dart';

ListCountryModel listCountryModel = ListCountryModel();
ListNationalities listNationalities = ListNationalities();
List<String> countryCity = [];
List<String> countryId = [];
List<String> countryNationCity = [];
List<String> countryNationId = [];

void getCountry() {
  countryCity = [];
  countryId = [];

  for (int i = 0; i < listCountryModel.data!.length; i++) {
    countryCity.add(listCountryModel.data![i].name!);
    countryCity.sort((a, b) {
      return a.toString().toLowerCase().compareTo(b.toString().toLowerCase());
    });

    countryId.add(listCountryModel.data![i].id!.toString());
  }
  if (kDebugMode) {
    print(countryCity);
    print(countryId);
  }
}

void getCountryNation() {
  countryNationCity = [];
  countryNationId = [];
  for (int i = 0; i < listNationalities.data!.length; i++) {
    countryNationCity.add(listNationalities.data![i].name!);
    countryNationCity.sort((a, b) {
      return a.toString().toLowerCase().compareTo(b.toString().toLowerCase());
    });
    countryNationId.add(listNationalities.data![i].id!.toString());
  }
  if (kDebugMode) {
    print("countryNationCity => $countryNationCity");
    print("countryNationCity => $countryNationId");
  }
}

String getChatId(String uid1, String uid2) {
  if (uid1.hashCode > uid2.hashCode) {
    return '${uid1}_$uid2';
  } else {
    return '${uid2}_$uid1';
  }
}

String getFormattedTime(DateTime time, {DateFormat? format}) {
  if (isToday(time)) {
    if (format != null) {
      return format.format(time);
    } else {
      return DateFormat("h:mm a").format(time);
    }
  } else if (isYesterday(time)) {
    return "Yesterday";
  } else if (isInWeek(time)) {
    return DateFormat("EEEE").format(time);
  } else if (isInMonth(time)) {
    return DateFormat("dd/MM").format(time);
  } else if (isInYear(time)) {
    return DateFormat("MMMM").format(time);
  } else {
    return time.year.toString();
  }
}

bool isToday(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year && now.month == time.month && now.day == time.day) {
    return true;
  }
  return false;
}

bool isYesterday(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year &&
      now.month == time.month &&
      ((now.day - 1) == time.day)) {
    return true;
  }
  return false;
}

bool isInWeek(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year &&
      now.month == time.month &&
      ((now.day - 6) > time.day)) {
    return false;
  }
  return true;
}

bool isInMonth(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year && now.month == time.month) {
    return true;
  }
  return false;
}

bool isInYear(DateTime time) {
  DateTime now = DateTime.now();

  if (now.year == time.year) {
    return true;
  }
  return false;
}

String getAlertString(DateTime time) {
  if (isToday(time)) {
    return "Today";
  } else if (isYesterday(time)) {
    return "Yesterday";
  }
  return DateFormat('dd MMMM yyyy').format(time);
}


/// Get Current Location LatLong
Future<LatLng> getCurrentLatLang() async {
  LocationPermission permission = await Geolocator.checkPermission();
  // loader.value = true;
  if (permission == LocationPermission.denied) {
    LocationPermission result = await Geolocator.requestPermission();
    if (result == LocationPermission.always ||
        result == LocationPermission.whileInUse) {
      getCurrentLatLang();
    }
    return const LatLng(0, 0);
  } else {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return LatLng(position.latitude, position.longitude);
  }
  // loader.value = false;
}
