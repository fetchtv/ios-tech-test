//
//  StationsTableVCWrapper.swift
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

import SwiftUI
import UIKit

struct StationsViewControllerWrapper: UIViewRepresentable {

    func makeUIView(context: Context) -> UIView {
        let service = NetworkService()
        let viewModel = StationsTableViewModel(networkService: service)

        guard let tableViewController = StationsTableViewController(viewModel: viewModel) else {
            return UIView()
        }

        return tableViewController.view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view if needed
    }
}
