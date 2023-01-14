//
//  ContentView.swift
//  AsTheCrowFlies
//
//  Created by Joshua Kaden on 1/14/23.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var showMap: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "bird.fill")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("As The Crow Flies")
                Button("Start") {
                    showMap = true
                }
            }
            .padding()
            .navigationDestination(isPresented: $showMap) {
                MapView(viewModel: MapViewModel())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
