//
//  TrackView.swift
//  iMap
//
//  Created by Mohamed El-Halawani on 2024-11-15.
//

import SwiftUI
import MapKit
import CoreLocation

struct TrackView: View {
    
    @StateObject var locationTracker = LocationTracker()
    
    let region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 45.4201,
            longitude: -75.7003
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.3,
            longitudeDelta: 0.3
        )
    )
    
    var body: some View {
        Map(initialPosition: .region(region)) {
            if let currentLocation = locationTracker.location {
                Marker(
                    "Current Location",
                    coordinate: currentLocation.coordinate
                )
            }
        }
            .ignoresSafeArea()
            .onAppear() {
                locationTracker.setUp()
                locationTracker.startTracking()
            }
            .onDisappear() {
                locationTracker.stopTracking()
            }
    }
}

class LocationTracker: NSObject {
    
    private let locationManager = CLLocationManager()
    @Published var locations: [CLLocation]?
    @Published var location: CLLocation?
    
    init(locations: [CLLocation]? = nil) {
        self.locations = locations
        self.location = nil
    }
    
    func setUp() {
        locationManager.delegate = self
        
        if locationManager.authorizationStatus != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func startTracking() {
        locationManager.startUpdatingLocation()
    }
    
    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationTracker: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currentLocation = locations.first {
            self.location = currentLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}


extension LocationTracker: ObservableObject { }

#Preview {
    TrackView()
}
