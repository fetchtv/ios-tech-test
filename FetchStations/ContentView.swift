//
//  ContentView.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        StationsViewControllerWrapper()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
