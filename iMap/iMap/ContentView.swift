//
//  ContentView.swift
//  iMap
//
//  Created by Mohamed El-Halawani on 2024-11-13.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    
    let initialPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 45.4201,
                longitude: -75.7003
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1
            )
        )
    )
    
    let locations = [
        Location(name: "Parliament Hill", coordinate: CLLocationCoordinate2D(latitude: 45.4236, longitude: -75.7009)),
        Location(name: "Canadian Museum of History", coordinate: CLLocationCoordinate2D(latitude: 45.4296, longitude: -75.7103)),
        Location(name: "Rideau Canal", coordinate: CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.6972)),
        Location(name: "ByWard Market", coordinate: CLLocationCoordinate2D(latitude: 45.4275, longitude: -75.6924)),
        Location(name: "National Gallery of Canada", coordinate: CLLocationCoordinate2D(latitude: 45.4294, longitude: -75.6984))
    ]
    
    let algon =  Location(name: "Algonquin College", coordinate: CLLocationCoordinate2D(latitude: 45.3498, longitude: -75.7554))
    
    @State var selectedLocation: Location?
    
//    let locationManager = CLLocationManager()
    
    var body: some View {
        Map(initialPosition: initialPosition) {
            ForEach(locations, id: \.id) { location in
                Marker(
                    location.name,
                    coordinate: location.coordinate
                )
            }
            
            Annotation(algon.name, coordinate: algon.coordinate) {
                
                Button {
                    
                    selectedLocation = algon
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(.gray)
                            .opacity(0.4)
                            .cornerRadius(20)
                        VStack {
                            Image(systemName: "star.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                            Text(algon.name)
                                .font(.headline)
                        }
                        .padding()
                        
                    }
                }
            }
            
            UserAnnotation()
        }
        .ignoresSafeArea()
        .onAppear() {
//            locationManager.requestWhenInUseAuthorization()
        }
        .alert(
            "Selected Location",
            isPresented: .constant(selectedLocation != nil) ) {
                Text("the location name is: \(selectedLocation?.name)")
                
                Button("OK") {
                    selectedLocation = nil
                }
            }
    }
}

#Preview {
    ContentView()
}
