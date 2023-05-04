//
//  StationsTableVCWrapper.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import SwiftUI
import UIKit

struct StationsViewControllerWrapper: UIViewRepresentable {

    let viewController: StationsTableViewController
    let locationViewModel: LocationViewModel
    let viewModel: StationsTableViewModel

    init(locationViewModel: LocationViewModel) {
        self.locationViewModel = locationViewModel
        self.viewModel = StationsTableViewModel(networkService: NetworkServiceObjc())
        self.viewController = StationsTableViewController(viewModel: viewModel)
        self.fetchDataInBackground()
    }

    func makeUIView(context: Context) -> UIView {
        return viewController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }

    private mutating func fetchDataInBackground() {
        switch locationViewModel.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationViewModel.location else {
                return
            }

            viewModel.fetchData(from: location)
        default:
            break
        }
    }
}
