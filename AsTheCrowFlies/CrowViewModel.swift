//
//  CrowViewModel.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import Foundation
import MapKit

final class CrowViewModel: ObservableObject {
    static let defaultRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CrowViewModel.massGeneralCoordinate2D,
        latitudinalMeters: 750,
        longitudinalMeters: 750)
    
    static let massGeneralCoordinate2D = CLLocationCoordinate2D(latitude: 42.362896, longitude: -71.069091)
    
    @Published var perchPlacemark: MKPlacemark = MKPlacemark(coordinate: CrowViewModel.massGeneralCoordinate2D)
    @Published var placemarks: [MKPlacemark] = []
    private(set) var previousPlacemarks: [MKPlacemark] = []
    
    private let geocoder = CLGeocoder()
    
    init() {
        findPlacemarksFromCoordinate(CrowViewModel.massGeneralCoordinate2D) { [weak self] placemarks in
            guard let placemark = placemarks.first else {
                return
            }
            self?.perchPlacemark = placemark
        }
    }
    
    func findPlacemarksFromCoordinate(_ coordinate: CLLocationCoordinate2D, completion: @escaping ([MKPlacemark]) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemarks else {
                completion([])
                return
            }
            completion(placemarks.map { MKPlacemark(placemark: $0) })
        }
    }
    
    func appendPlacemarks(_ placemarks: [MKPlacemark]) {
        previousPlacemarks = self.placemarks
        for placemark in placemarks {
            if self.placemarks.filter({ $0.title == placemark.title }).count == 0 {
                self.placemarks.append(placemark)
            }
        }
    }
}
