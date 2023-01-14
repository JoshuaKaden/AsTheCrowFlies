//
//  MapView.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import MapKit
import SwiftUI

struct MapView: View {
    // MARK: - State Variables
    
    @State var region: MKCoordinateRegion = Self.defaultRegion
    
    // MARK: - Static properties
    
    static let defaultRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: Self.massGeneralCoordinate2D,
        latitudinalMeters: 750,
        longitudinalMeters: 750)
    
    static let massGeneralCoordinate2D = CLLocationCoordinate2D(latitude: 42.362957, longitude: -71.068642)
    
    // MARK: - Body
    
    var body: some View {
        Map(coordinateRegion: $region)
            .navigationTitle("As The Crow Flies")
            .onTapGesture { location in
              print("Tapped at \(location)")
            }
    }
}

// MARK: - Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
