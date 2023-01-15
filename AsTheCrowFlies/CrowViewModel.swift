//
//  CrowViewModel.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import Foundation
import MapKit

final class CrowViewModel: ObservableObject {
    @Published var placemarks: [MKPlacemark] = []
    private(set) var previousPlacemarks: [MKPlacemark] = []
    
    private let geocoder = CLGeocoder()
    
    func findPlacemarksFromCoordinate(_ coordinate: CLLocationCoordinate2D, completion: @escaping ([MKPlacemark]) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self, let placemarks else {
                return
            }
            self.previousPlacemarks = self.placemarks
            self.placemarks.append(contentsOf: placemarks.map { MKPlacemark(placemark: $0) })
        }
    }
    
    func appendPlacemarks(_ placemarks: [MKPlacemark]) {
        previousPlacemarks = self.placemarks
        self.placemarks.append(contentsOf: placemarks)
    }
}
