import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mnadeby/screens/mnadeby/mandob_tracking_screen/bloc/mandob_tracking_bloc.dart';
import 'package:mnadeby/screens/orders/order_details_screen/OrderDetailsScreen.dart';

late String mandobuId;
late String mandobName;

class MandobTrackingScreen extends StatefulWidget {


  @override
  State<MandobTrackingScreen> createState() => _MandobTrackingScreenState();

  MandobTrackingScreen({required String mandobId, required String mandobNamee}) {
    mandobuId = mandobId;
    mandobName = mandobNamee;
  }
}


class _MandobTrackingScreenState extends State<MandobTrackingScreen> {
  Completer<GoogleMapController>_Mapcontroller = Completer();

  BitmapDescriptor mandobIcon = BitmapDescriptor.defaultMarker;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      MandobTrackingBloc()
        ..getMandobLocation(uId: mandobuId),
      child: BlocConsumer<MandobTrackingBloc, MandobTrackingState>(
        listener: (context, state) {},
        builder: (context, state) {
          MandobTrackingBloc bloc = MandobTrackingBloc.get(context);
          return Scaffold(
            body: SafeArea(
                child: state is GetMandobTrackingLoadingState? Center(child: CircularProgressIndicator(),) : Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(bloc.latitude, bloc.longitude),
                          bearing: 0.0,
                          zoom: 18
                      ),
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _Mapcontroller.complete(controller);
                        setState(() {
                          BitmapDescriptor.fromAssetImage(
                              ImageConfiguration.empty, 'assets/images/del.png')
                              .then((onValue) {
                            print("done");
                            mandobIcon = onValue;
                          });
                        });
                      },
                      markers: {
                        Marker(markerId: MarkerId("$mandobName"),
                          icon: mandobIcon,
                          position: LatLng(bloc.latitude, bloc.longitude),
                        ),
                      },
                      polylines: {
                        Polyline(polylineId: PolylineId("ss"),
                            width: 6,
                            color: Colors.green
                        )
                      },
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white.withOpacity(0.8),
                      child: Text("تتبع المندوب - ${mandobName}",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                )
            ),
          );
        },
      ),
    );
  }

}


