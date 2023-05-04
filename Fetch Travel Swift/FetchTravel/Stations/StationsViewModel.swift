//
//  StationsViewModel.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import Foundation
import CoreLocation

protocol ReactiveDataDelegate: AnyObject {
    func alertUserWith(_ error: Error)
    func updateTableView()
}

class StationsViewModel {
    weak var delegate: ReactiveDataDelegate?
    lazy var stations = [Station]()

    let networkService: NetworkService
    let title = "Fetch Transport"

    var numberOfRows: Int {
        stations.count
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchStationsFrom(location: CLLocation) async {
        let response = await networkService.getStations(with: location)

        switch response {
        case .success(let stationResponse):
            stations = stationResponse.stations
            delegate?.updateTableView()
        case .failure(let error):
            delegate?.alertUserWith(error)
        }
    }
}
