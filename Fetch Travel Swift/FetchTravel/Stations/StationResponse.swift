//
//  Station.swift
//  FetchTravel
//
//  Created by Waylan Sands on 4/5/2023.
//

import Foundation

struct StationResponse: Codable {
    let stations: [Station]
}

struct Station: Codable {
    let place: Place
}

struct Place: Codable {
    let name: String
    let type: String
    let id: String
}
