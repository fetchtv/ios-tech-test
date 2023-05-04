//
//  DeparturesViewModel.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import Foundation

class DeparturesViewModel {
    weak var delegate: ReactiveDataDelegate?
    lazy var departures = [Departure]()

    let networkService: NetworkService
    let title = "Departures"

    var numberOfRows: Int {
        departures.count
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchDepartures(with id: String) async {
        let response = await networkService.getDepartures(with: id)

        switch response {
        case .success(let departureResponse):
            guard let boarding = departureResponse.boards.first,
                  let departures = boarding.departures else {
                return
            }

            self.departures = departures
            delegate?.updateTableView()
        case .failure(let error):
            delegate?.alertUserWith(error)
        }
    }
}
