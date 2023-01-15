//
//  CrowView.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import Contacts
import MapKit
import SwiftUI

struct CrowView: View {
    @ObservedObject var viewModel: CrowViewModel
    
    var body: some View {
        VStack {
            MapView(viewModel: viewModel)
            List(viewModel.placemarks) { placemark in
                Text(placemark.description)
            }
        }
    }
}

extension MKPlacemark: Identifiable {
    
}
