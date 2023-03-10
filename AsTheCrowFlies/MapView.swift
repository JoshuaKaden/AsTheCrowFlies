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
        
    // MARK: - Private Properties
    
    private let mapView = MKMapView()
    
    // MARK: - NSViewRepresentable
    
    func makeNSView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        mapView.region = CrowViewModel.defaultRegion
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "MARKER")
        mapView.addAnnotation(viewModel.perchPlacemark)
        mapView.addAnnotations(viewModel.placemarks)
        return mapView
    }

    func updateNSView(_ nsView: MKMapView, context: Context) {
        nsView.removeAnnotations(viewModel.previousPlacemarks)
        nsView.addAnnotations(viewModel.placemarks)
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
            parent.viewModel.findPlacemarksFromCoordinate(coordinate) { [weak self] placemarks in
                guard let parent = self?.parent else {
                    return
                }
                parent.viewModel.appendPlacemarks(placemarks)
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "MARKER")
            if annotation.coordinate.latitude == CrowViewModel.massGeneralCoordinate2D.latitude && annotation.coordinate.longitude == CrowViewModel.massGeneralCoordinate2D.longitude {
                annotationView.glyphTintColor = .white
                annotationView.markerTintColor = .black
            } else {
                annotationView.glyphTintColor = .white
                annotationView.markerTintColor = .blue
            }
            return annotationView
        }
    }

}

// MARK: - Previews

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(viewModel: CrowViewModel())
    }
}
