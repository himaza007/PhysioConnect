import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearbyFacilitiesScreen extends StatefulWidget {
  const NearbyFacilitiesScreen({super.key});

  @override
  _NearbyFacilitiesScreenState createState() => _NearbyFacilitiesScreenState();
}

class _NearbyFacilitiesScreenState extends State<NearbyFacilitiesScreen>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  late TabController _tabController;
  bool _isLoading = true;

  // Separate marker sets for each category
  final Set<Marker> _hospitalMarkers = {};
  final Set<Marker> _doctorMarkers = {};
  final Set<Marker> _physiotherapistMarkers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    _getUserLocation();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        // Update markers based on selected tab
        switch (_tabController.index) {
          case 0:
            _markers.clear();
            _markers.addAll(_hospitalMarkers);
            break;
          case 1:
            _markers.clear();
            _markers.addAll(_doctorMarkers);
            break;
          case 2:
            _markers.clear();
            _markers.addAll(_physiotherapistMarkers);
            break;
        }
      });
    }
  }

  // Get User's Current Location
  Future<void> _getUserLocation() async {
    setState(() {
      _isLoading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = position;
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)),
      );
    });

    // Fetch all three categories
    await Future.wait([
      _fetchNearbyFacilities(
        position.latitude,
        position.longitude,
        "hospital",
        _hospitalMarkers,
      ),
      _fetchNearbyFacilities(
        position.latitude,
        position.longitude,
        "doctor",
        _doctorMarkers,
      ),
      _fetchNearbyFacilities(
        position.latitude,
        position.longitude,
        "physiotherapist",
        _physiotherapistMarkers,
      ),
    ]);

    // Set initial markers based on first tab
    setState(() {
      _markers.addAll(_hospitalMarkers);
      _isLoading = false;
    });
  }

  // Fetch Nearby Facilities by type
  Future<void> _fetchNearbyFacilities(
    double lat,
    double lng,
    String type,
    Set<Marker> markerSet,
  ) async {
    const apiKey = "AIzaSyAUiLi358QxvTGF8oKIkZ43kcHMsiTQ2YE";
    const radius = 5000; // Search within 5km

    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=$radius&type=$type&key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> places = data["results"];

      setState(() {
        markerSet.clear();
        for (var place in places) {
          final marker = Marker(
            markerId: MarkerId(place["place_id"]),
            position: LatLng(
              place["geometry"]["location"]["lat"],
              place["geometry"]["location"]["lng"],
            ),
            infoWindow: InfoWindow(
              title: place["name"],
              snippet: place["vicinity"],
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              type == "hospital"
                  ? BitmapDescriptor.hueRed
                  : type == "doctor"
                  ? BitmapDescriptor.hueBlue
                  : BitmapDescriptor.hueGreen,
            ),
          );
          markerSet.add(marker);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF33724B),
        title: const Text("Nearby Facilities Locator"),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.local_hospital, color: Colors.white),
              child: Text("Hospitals", style: TextStyle(color: Colors.black)),
            ),
            Tab(
              icon: Icon(Icons.medical_services, color: Colors.white),
              text: "Doctors",
            ),
            Tab(
              icon: Icon(Icons.healing, color: Colors.white),
              text: "Physiotherapists",
            ),
          ],
        ),
      ),
      body:
          _isLoading || _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        _currentPosition!.latitude,
                        _currentPosition!.longitude,
                      ),
                      zoom: 14,
                    ),
                    myLocationEnabled: true,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        _tabController.index == 0
                            ? "Showing nearby hospitals"
                            : _tabController.index == 1
                            ? "Showing nearby doctors"
                            : "Showing nearby physiotherapists",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
