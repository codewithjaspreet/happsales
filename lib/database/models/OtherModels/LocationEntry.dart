 import 'LocationEntryBase.dart';

class LocationEntry  extends  LocationEntryBase{

     LocationEntry(String timeId, double latitude, double longitude) {
        this.timeId = timeId;
        this.latitude = latitude;
        this.longitude = longitude;
    }
}