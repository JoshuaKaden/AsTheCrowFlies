//
//  MapViewModel.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import Foundation
import CoreLocation

final class MapViewModel: ObservableObject {
    private let geocoder = CLGeocoder()
    
    func didClickCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            let addressCoordinate = placemarks?.first
            print("*** \(addressCoordinate) ***")
        }
    }
}
