import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:happsales_crm/viewmodels/login_view_model.dart';

class LocationController extends GetxController {
  RxString? currentAddress;
  Position? currentPosition;

  Future<void> getCurrentPosition() async {
    final hasPermission = LoginController().location.value;

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      print(currentPosition);
      getAddressFromLatLng(currentPosition!);
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}'
              as RxString?;

      print(currentAddress);
    }).catchError((e) {
      print(e);
    });
  }
}
