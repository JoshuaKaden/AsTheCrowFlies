//
//  MapViewModel.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import Foundation
import MapKit

final class MapViewModel: ObservableObject {
    func didClickCoordinate(_ coordinate: CLLocationCoordinate2D) {
        print("*** \(coordinate) ***")
    }
}
