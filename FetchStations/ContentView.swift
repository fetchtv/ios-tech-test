//
//  ContentView.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationViewModel = LocationViewModel()

    var body: some View {
        StationsViewControllerWrapper(locationViewModel: locationViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear(perform: {
                locationViewModel.requestPermission()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
