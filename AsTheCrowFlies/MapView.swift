//
//  MapView.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import MapKit
import SwiftUI

struct MapView: NSViewRepresentable {
    typealias NSViewType = MKMapView
    
    let viewModel: CrowViewModel
    
    static let defaultRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: Self.massGeneralCoordinate2D,
        latitudinalMeters: 750,
        longitudinalMeters: 750)
    
    static let massGeneralCoordinate2D = CLLocationCoordinate2D(latitude: 42.362957, longitude: -71.068642)
    
    // MARK: - Private Properties
    
    private let mapView = MKMapView()
    
    // MARK: - NSViewRepresentable
    
    func makeNSView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.region = Self.defaultRegion
        mapView.addAnnotations(viewModel.placemarks)
        return mapView
    }

    func updateNSView(_ nsView: MKMapView, context: Context) {
        mapView.removeAnnotations(viewModel.previousPlacemarks)
        mapView.addAnnotations(viewModel.placemarks)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate, NSGestureRecognizerDelegate {
        var parent: MapView

        var gRecognizer = NSClickGestureRecognizer()

        init(_ parent: MapView) {
            self.parent = parent
            super.init()
            self.gRecognizer = NSClickGestureRecognizer(target: self, action: #selector(clickHandler))
            self.gRecognizer.delegate = self
            self.parent.mapView.addGestureRecognizer(gRecognizer)
        }

        @objc func clickHandler(_ gesture: NSClickGestureRecognizer) {
            // position on the screen, CGPoint
            let location = gRecognizer.location(in: self.parent.mapView)
            // position on the map, CLLocationCoordinate2D
            let coordinate = self.parent.mapView.convert(location, toCoordinateFrom: self.parent.mapView)
            parent.viewModel.didClickCoordinate(coordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            return MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: String(describing: annotation.coordinate))
        }
    }

}

// MARK: - Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: CrowViewModel())
    }
}
